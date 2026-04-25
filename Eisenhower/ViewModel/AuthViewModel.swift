//
//  AuthViewModel.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 21/04/26.
//

import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    
    // MARK: - Repo
    private var repository: UserRepository = UserRepository()
    
    // MARK: - State
    @Published var isLoading: Bool = false
    @Published var result: UserResponse?
    @Published var err: String?
    @Published var isError: Bool = false
    
    // MARK: - Actions
    
    func login(email: String, password: String) async {
        isLoading = true
        do {
            result = try await repository.login(user: User(email: email, password: password))
            isLoading = false
        } catch {
            isLoading = false
            isError = true
            if let e = error as? NetworkError {
                err = e.message
                return
            }
            err = error.localizedDescription
        }
    }
    
    func register(name: String, email: String, password: String) async {
        isLoading = true
        do {
            _ = try await repository.register(user: User(name: name, email: email, password: password))
            isLoading = false
        } catch {
            isError = true
            isLoading = false
            if let e = error as? NetworkError {
                err = e.message
                return
            }
            
            err = error.localizedDescription
        }
    }
}
