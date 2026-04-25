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
        popToRoot()
        route = [path]
    }
    
    func popToRoot() {
        route.removeAll()
    }
}

struct AppNavigation: View {
    // MARK: - App Storage
    @AppStorage("token") var token: String?
    
    @State private var router = Router()
    
    // MARK: - ViewModel
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel()
    @StateObject private var taskViewModel: TaskViewModel = TaskViewModel()
    @StateObject private var promptViewModel: PromptViewModel = PromptViewModel()
  
    
   var body: some View {
        NavigationStack(path: $router.route) {
            if token?.isEmpty == false {
                HomeScreen()
            } else {
                LoginScreen()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .login:
                            LoginScreen()
                                .navigationBarBackButtonHidden()
                        case .register:
                            RegisterScreen()
                                .navigationBarBackButtonHidden()
                        case .home:
                            HomeScreen()
                                .navigationBarBackButtonHidden()
                        }
                    }
            }
        }
        .environment(router)
        .environmentObject(authViewModel)
        .environmentObject(taskViewModel)
        .environmentObject(promptViewModel)
    }
}
