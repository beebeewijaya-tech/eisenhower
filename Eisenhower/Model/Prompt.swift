//
//  Promp.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 25/04/26.
//

import Foundation
import FoundationModels


enum LLMError: Error {
    case message(String)
}

@Generable
struct TaskBreakdown {
    var doFirst: [GeneratedTask]
    var schedule: [GeneratedTask]
    var delegate: [GeneratedTask]
    var eliminate: [GeneratedTask]
}

@Generable
struct GeneratedTask: Equatable {
    var title: String
    var description: String
    var deadline: String
    var quadrant: Quadrant
}
