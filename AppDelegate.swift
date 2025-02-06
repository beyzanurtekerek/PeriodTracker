//
//  AppDelegate.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 10.01.2025.
//
// BURAYA BİR BAKILACAK
import Foundation
import UIKit
import GoogleSignIn
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            FirebaseApp.configure()
            return true
        }
    
    @available(iOS 9.0, *)
        func application(_ application: UIApplication, open url: URL,
                         options: [UIApplication.OpenURLOptionsKey: Any])
          -> Bool {
          return GIDSignIn.sharedInstance.handle(url)
        }

}
