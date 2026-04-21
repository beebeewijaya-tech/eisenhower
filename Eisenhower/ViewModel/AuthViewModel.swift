//
//  AuthViewModel.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 21/04/26.
//

import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    private var repository: UserRepository = UserRepository()
    
    @Published var isLoading: Bool = false
    @Published var result: User?
    @Published var err: String?
    @Published var isError: Bool = false
    
    func login(email: String, password: String) async {
        isLoading = true
        do {
            try? await Task.sleep(nanoseconds: 1_000_000_000 * 3)
            _ = try await repository.login(user: User(email: email, password: password))
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
}
