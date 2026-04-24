//
//  TaskRepository.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 23/04/26.
//

import Foundation


class TaskRepository {
    private var networkService: NetworkService = NetworkService()
    
    func list() async throws -> [Task] {
        do {
            let res = try await networkService.get(path: "tasks")
            return try JSONDecoder().decode([Task].self, from: res)
        } catch {
            throw error
        }
    }
}
