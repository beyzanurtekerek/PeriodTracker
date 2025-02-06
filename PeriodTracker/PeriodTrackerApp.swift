//
//  PeriodTrackerApp.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 10.01.2025.
//

import SwiftUI
import Firebase
import GoogleSignIn
import GoogleSignInSwift

@main
struct PeriodTrackerApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
    
}

