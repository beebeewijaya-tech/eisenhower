//
//  AppNavigation.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 21/04/26.
//

import SwiftUI
import Combine

enum Route: Hashable {
    case login
    case register
    case home
}

@Observable
class Router {
    var route: [Route] = []

    func navigate(path: Route) {
        route.append(path)
    }
    
    func pop() {
        route.removeLast()
    }
    
    func replaceAll(path: Route) {
        route = [path]
    }
    
    func popToRoot() {
        route.removeAll()
    }
}

struct AppNavigation: View {
    @State private var router = Router()
    
    // MARK: - ViewModel
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack(path: $router.route) {
            LoginScreen()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .login:
                        LoginScreen()
                    case .register:
                        RegisterScreen()
                            .navigationBarBackButtonHidden()
                    case .home:
                        HomeScreen()
                    }
                }
        }
        .environment(router)
        .environmentObject(authViewModel)
    }
}
