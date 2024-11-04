//
//  VoyageVaultAppApp.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-18.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main

struct VoyageVaultAppApp: App {
    
    @StateObject var firebaseAuth = FirebaseAuth()
    @StateObject var firestorage = Firestorage(firebase: FirebaseAuth())
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(firebaseAuth).environmentObject(firestorage)
        }
    }
}
