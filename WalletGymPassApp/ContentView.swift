import SwiftUI
import PassKit
import Firebase
import FirebaseStorage

struct ContentView: View {
    @State private var backgroundColor: Color = .white
    @State private var textColor: Color = .black
    @State private var name: String = ""
    @State private var id: String = ""
    
    // New state properties for image picking
    @State private var showingImagePicker: Bool = false
    @State private var selectedImage: UIImage? = nil
    
    var body: some View {
        ZStack {
            // Use a custom background color (from your asset catalog)
            Color("Main")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Logo image styled as a resizable image with appropriate aspect ratio
                Image("LSDW")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 120)
                    .padding(.top, 50)
                
                // Card container grouping all form elements
                VStack(spacing: 20) {
                    
                    // Background Color Picker Row
                    HStack {
                        Text("Background:")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                        ColorPicker("", selection: $backgroundColor)
                            .labelsHidden()
                    }
                    
                    // Text Color Picker Row
                    HStack {
                        Text("Text Color:")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                        ColorPicker("", selection: $textColor)
                            .labelsHidden()
                    }
                    
                    // Modern Text Field for Name
                    TextField("Enter Name", text: $name)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .foregroundColor(textColor)
                        .font(.system(size: 18, weight: .medium))
                    
                    // Modern Text Field for ID Number (with number pad)
                    TextField("Enter ID Number", text: $id)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .foregroundColor(textColor)
                        .font(.system(size: 18, weight: .medium))
                    
                    // Pass Image Upload Section
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        HStack {
                            Image(systemName: "photo.on.rectangle")
                            Text(selectedImage == nil ? "Upload Pass Image" : "Change Pass Image")
                        }
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.ultraThinMaterial)
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white.opacity(0.3))
                            }
                        )
                        .foregroundColor(.black)
                    }

                    
                    AddPassToWalletButton {
                        
                    }
                    .frame(maxWidth: .infinity,maxHeight: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding()
                // Card styling with thin material background, rounded corners, and shadow
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding()
        }
        // Present the image picker as a sheet when the button is tapped
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - ImagePicker: A UIKit Wrapper for UIImagePickerController

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
         let picker = UIImagePickerController()
         picker.sourceType = sourceType
         picker.delegate = context.coordinator
         return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No updates needed
    }
    
    func makeCoordinator() -> Coordinator {
         Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
         let parent: ImagePicker
         
         init(_ parent: ImagePicker) {
             self.parent = parent
         }
         
         func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
             if let image = info[.originalImage] as? UIImage {
                 parent.selectedImage = image
             }
             parent.presentationMode.wrappedValue.dismiss()
         }
         
         func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
             parent.presentationMode.wrappedValue.dismiss()
         }
    }
}
