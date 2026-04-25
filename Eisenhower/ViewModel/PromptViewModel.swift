//
//  PromptViewModel.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 25/04/26.
//

import Foundation
import FoundationModels
import Combine


class PromptViewModel: ObservableObject {
    @Published var isError: Bool = false
    @Published var err: String? = nil
    @Published var isLoading: Bool = false
    @Published var result: [GeneratedTask] = []
    
    func generate(prompt: String) async {
        isLoading = true
        do {
            let model = SystemLanguageModel.default
            guard case .available = model.availability else {
                err = "Apple Intelligence not available"
                return
            }
            
            let session = LanguageModelSession()
            let response = try await session.respond(
                to: "Break down this goal into tasks: \(prompt) remember to distribute tasks across all quadrants appropriately [DO_FIRST, SCHEDULE, DELEGATE, ELIMINATE], but since its one line on description, keep everything simple, please make it easy format like TASK TITLE, TASK DESCRIPTION, DEADLINE using yyyy-MM-dd, also each quadrant can has many task don't just put on single quadrant, like if you have a lot just break it down, please CATEGORIZE THE QUADRANT carefully, remember that currently is 2026-04-25 just make the deadline greater than today with a lot of SENSE of the deadline",
                generating: TaskBreakdown.self
            )
            let breakdown = response.content
            result = breakdown.doFirst + breakdown.delegate + breakdown.schedule + breakdown.eliminate
            isLoading = false
        } catch {
            print(error)
            isError = true
            isLoading = false
            err = error.localizedDescription
        }
    }
}
