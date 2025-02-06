//
//  ColorExtension.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 8.01.2025.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
        if hexSanitized.count == 6 {
            let scanner = Scanner(string: hexSanitized)
            var rgb: UInt64 = 0
            scanner.scanHexInt64(&rgb)
            
            self.init(
                .sRGB,
                red: Double((rgb & 0xFF0000) >> 16) / 255.0,
                green: Double((rgb & 0x00FF00) >> 8) / 255.0,
                blue: Double(rgb & 0x0000FF) / 255.0,
                opacity: 1.0
            )
        } else {
            self.init(.clear)
        }
    }
}
