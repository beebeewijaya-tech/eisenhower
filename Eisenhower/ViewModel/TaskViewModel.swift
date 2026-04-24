//
//  TaskViewModel.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 23/04/26.
//

import Foundation
import Combine

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var isLoading: Bool = false
    @Published var err: String = ""
    @Published var isError: Bool = false
    private var taskRepository: TaskRepository = TaskRepository()
    
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
}
