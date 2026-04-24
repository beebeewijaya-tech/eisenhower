//
//  TaskViewModel.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 23/04/26.
//

import SwiftUI
import Combine

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var isLoading: Bool = false
    @Published var err: String = ""
    @Published var isError: Bool = false
    private var taskRepository: TaskRepository = TaskRepository()
    var quadrant: [QuadrantItem] = [
        QuadrantItem(name: "Do First", description: "Urgent and Important", color: Color("Secondary"), type: "DO_FIRST"),
        QuadrantItem(name: "Schedule", description: "Not Urgent and Important", color: Color("Cyan"), type: "SCHEDULE"),
        QuadrantItem(name: "Delegate", description: "Urgent and Not Important", color: Color.gray, type: "DELEGATE"),
        QuadrantItem(name: "Eliminate", description: "Not Urgent and Not Important", color: Color("Red"), type: "ELIMINATE")
    ]
    
    func list() async {
        isLoading = true
        do {
            let res = try await taskRepository.list()
            tasks = res
            isLoading = false
        } catch {
            print(error)
            isError = true
            isLoading = false
            if let errMsg = error as? NetworkError {
                err = errMsg.message
                return
            }
            
            err = error.localizedDescription
        }
    }
    
    func add(task: TaskRequest) async {
        isLoading = true
        do {
            let res = try await taskRepository.add(task: task)
            tasks.append(res)
            isLoading = false
        } catch {
            print("ADD Task: ", error)
            isError = true
            isLoading = false
            if let errMsg = error as? NetworkError {
                err = errMsg.message
                return
            }
            
            err = error.localizedDescription
        }
    }
}
