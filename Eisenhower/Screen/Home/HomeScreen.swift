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
    @EnvironmentObject private var promptViewModel: PromptViewModel
    
    // MARK: - State
    @State var addAITaskPresented: Bool = false
    @State var promptText: String = ""
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color("White")
                .ignoresSafeArea()
            
            if taskViewModel.isLoading {
                ProgressView()
            } else if taskViewModel.isBulkLoading {
                VStack {
                    Spacer()
                    AppAvatar(avatar: "Process")
                    Text("Eisen currently doing it's \"MAGIC\"")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .bold()
                        .padding(.bottom, 10)
                    Text("Be patience, we are breaking down your tasks")
                        .font(.caption)
                        .bold()
                    Spacer()
                }
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
                AppImageButton(image: "wand.and.sparkles", width: 50, type: .primary) {
                    addAITaskPresented = true
                }
                .padding()
            }
        }
        // MARK: - Toolbar
        .toolbar {
            if !taskViewModel.isBulkLoading {
                ToolbarItem(placement: .primaryAction) {
                    Button("Logout", systemImage: "rectangle.portrait.and.arrow.right") {
                        token = ""
                    }
                }
            }
        }
        .addAITaskSheet(isPresented: $addAITaskPresented, text: $promptText, isLoading: promptViewModel.isLoading) {
            Swift.Task {
                if promptText.isEmpty {
                    return
                }
                addAITaskPresented = false
                taskViewModel.isBulkLoading = true
                await promptViewModel.generate(prompt: promptText)
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
        .toast(isPresenting: $promptViewModel.isError, alert: {
            AlertToast(
                type: .error(Color("Primary")),
                title: "Error",
                subTitle: promptViewModel.err
            )
        })
        .onChange(of: promptViewModel.result, { _, newValue in
            Swift.Task {
                await taskViewModel.bulkAdd(genTasks: newValue)
            }
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
        .environmentObject(PromptViewModel())
}
