//
//  WalletGymPassAppApp.swift
//  WalletGymPassApp
//
//  Created by Harry Phillips on 11/02/2025.
//

import SwiftUI
import SwiftData
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
    
    @main
    struct WalletGymPassAppApp: App {
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        var body: some Scene {
            WindowGroup {
                ContentView()
            }
        }
    }
}
