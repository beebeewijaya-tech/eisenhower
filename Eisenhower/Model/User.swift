//
//  User.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 21/04/26.
//

import SwiftUI

struct User: Codable, Identifiable {
    var id: UUID?
    var name: String?
    var email: String
    var password: String
}


struct UserResponse: Codable {
    var token: String?
}
