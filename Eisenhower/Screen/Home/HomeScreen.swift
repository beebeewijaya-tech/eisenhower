//
//  HomeScreen.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 21/04/26.
//

import SwiftUI

struct HomeScreen: View {
    // MARK: - Storage
    @AppStorage("token") var token: String?
    
    // MARK: - Environment
    @Environment(Router.self) private var router: Router
    
    // MARK: - ViewModel
    @EnvironmentObject private var authViewModel: AuthViewModel
    @EnvironmentObject private var taskViewModel: TaskViewModel
    
    // MARK: - State
    private var quadrant: [QuadrantItem] = [
        QuadrantItem(name: "Do First", description: "Urgent and Important", color: Color("Secondary"), type: "DO_FIRST"),
        QuadrantItem(name: "Schedule", description: "Not Urgent and Important", color: Color("Cyan"), type: "SCHEDULED"),
        QuadrantItem(name: "Delegate", description: "Urgent and Not Important", color: Color.gray, type: "DELEGATE"),
        QuadrantItem(name: "Eliminate", description: "Not Urgent and Not Important", color: Color("Red"), type: "ELIMINATE")
    ]
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
                            ForEach(quadrant) { item in
                                GridRow {
                                    QuadrantBox(
                                        bgColor: item.color,
                                        title: item.name,
                                        description: item.description,
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
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Logout", systemImage: "rectangle.portrait.and.arrow.right") {
                    token = ""
                }
            }
        }
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
