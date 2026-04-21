//
//  UserRepository.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 21/04/26.
//

import Foundation


class UserRepository {
    private var networkService: NetworkService = NetworkService()
    
    func login(user: User) async throws -> UserResponse {
        do {
            let data = try JSONEncoder().encode(user)
            let res = try await networkService.post(path: "auth/login", body: data)
            return try JSONDecoder().decode(UserResponse.self, from: res)
        } catch {
            throw error
        }
    }
    
    func register(user: User) async throws -> UserResponse{
        do {
            let data = try JSONEncoder().encode(user)
            let res = try await networkService.post(path: "auth/register", body: data)
            return try JSONDecoder().decode(UserResponse.self, from: res)
        } catch {
            throw error
        }
    }
}
