//
//  View.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 10.01.2025.
//
// BURAYA Bİ BAKILACAK
import Foundation
import SwiftUICore
import UIKit

extension View {
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }

        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        

        return root
    }
}
