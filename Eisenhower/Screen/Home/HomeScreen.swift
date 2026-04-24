//
//  HomeScreen.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 21/04/26.
//

import SwiftUI
import AlertToast

struct HomeScreen: View {
    // MARK: - Storage
    @AppStorage("token") var token: String?
    
    // MARK: - Environment
    @Environment(Router.self) private var router: Router
    
    // MARK: - ViewModel
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var taskViewModel: TaskViewModel
    
    // MARK: - State
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("White")
                .ignoresSafeArea()
            
            if taskViewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    VStack {
                        LazyVGrid(columns: columns) {
                            ForEach(taskViewModel.quadrant) { item in
                                GridRow {
                                    QuadrantBox(
                                        bgColor: item.color,
                                        title: item.name,
                                        description: item.description,
                                        quadrant: item.type,
                                        tasks: taskViewModel.tasks.filter({$0.quadrant.rawValue == item.type})
                                    )
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
            }
        }
        // MARK: - Toolbar
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Logout", systemImage: "rectangle.portrait.and.arrow.right") {
                    token = ""
                }
            }
        }
        .toast(isPresenting: $taskViewModel.isLoading, alert: {
            AlertToast(type: .loading)
        })
        .toast(isPresenting: $taskViewModel.isError, alert: {
            AlertToast(
                type: .error(Color("Primary")),
                title: "Error",
                subTitle: taskViewModel.err
            )
        })
        .onAppear {
            Swift.Task {
                await taskViewModel.list()
            }
        }
    }
}


#Preview {
    HomeScreen()
        .environment(Router())
        .environmentObject(AuthViewModel())
        .environmentObject(TaskViewModel())
}
