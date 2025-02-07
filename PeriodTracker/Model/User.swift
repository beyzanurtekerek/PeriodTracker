//
//  User.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 7.02.2025.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var firstName: String
    var lastName: String
    var email: String
}
