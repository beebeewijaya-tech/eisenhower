//
//  Task.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 23/04/26.
//

import SwiftUI

enum Quadrant: String, Codable {
    case doFirst = "DO_FIRST"
    case eliminate = "ELIMINATE"
    case delegate = "DELEGATE"
    case scheduled = "SCHEDULE"
}


struct Task: Codable, Identifiable {
    var id: UUID
    var title: String
    var description: String
    var quadrant: Quadrant
    var isCompleted: Bool
    var userId: String
    var deadline: String?
}


struct TaskRequest: Codable {
    var id: UUID?
    var title: String
    var description: String
    var deadline: String
    var quadrant: String
    var isCompleted: Bool?
}
