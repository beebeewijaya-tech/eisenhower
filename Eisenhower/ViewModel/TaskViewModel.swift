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
    
    func toggle(val: Bool, task: TaskRequest) async {
        do {
            _ = try await taskRepository.edit(task: task)
            tasks = tasks.map { t in
                var updated = t
                if updated.id == task.id {
                    updated.isCompleted = val
                }
                return updated
            }
        } catch {
            print("TOGGLE Task: ", error)
            isError = true
            if let errMsg = error as? NetworkError {
                err = errMsg.message
                return
            }
            
            err = error.localizedDescription
        }
    }
    
    func delete(id: UUID) async {
        do {
            _ = try await taskRepository.delete(id: id)
            tasks = tasks.filter({ $0.id != id })
        } catch {
            print("ERROR Task: ", error)
            isError = true
            if let errMsg = error as? NetworkError {
                err = errMsg.message
                return
            }
            
            err = error.localizedDescription
        }
    }
    
    
    func move(id: UUID, quadrant: Quadrant, task: TaskRequest) async {
        do {
            _ = try await taskRepository.edit(task: task)
            tasks = tasks.map({ t in
                var updated = t
                if t.id == id {
                    updated.quadrant = quadrant
                }
                return updated
            })
        } catch {
            print("MOVE task: ", error)
            isError = true
            if let errMsg = error as? NetworkError {
                err = errMsg.message
                return
            }
            err = error.localizedDescription
        }
    }
}
