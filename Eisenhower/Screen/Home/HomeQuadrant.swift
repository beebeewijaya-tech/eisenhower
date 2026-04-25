//
//  HomeQuadrant.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 24/04/26.
//

import SwiftUI

struct QuadrantItem: Identifiable {
    var id: UUID = UUID()
    var name = ""
    var description = ""
    var color: Color = .clear
    var type = ""
}

struct QuadrantBox: View {
    // MARK: - State
    @State private var isAddPresented: Bool = false
    @State private var taskTitle: String = ""
    @State private var taskDescription: String = ""
    @State private var taskQuadrant: String = ""
    @State private var taskDeadline: String = ""
    @State private var taskDate = Date()
    
    // MARK: - Property
    var bgColor: Color
    var title: String
    var description: String
    var quadrant: String
    var tasks: [Task]
    
    // MARK: - ViewModel
    @EnvironmentObject private var taskViewModel: TaskViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.body)
                        .bold()
                    
                    Text(description)
                        .foregroundStyle(.gray)
                        .font(.caption)
                }
                Spacer()
                AppImageButton(image: "plus") {
                    taskQuadrant = quadrant
                    isAddPresented = true
                }
            }
            .padding(.bottom, 20)
            
            ScrollView {
                LazyVStack {
                    ForEach(tasks) { task in
                        ListTask(
                            task: task,
                            bgColor: bgColor
                        ) { val, task in
                            Swift.Task {
                                await taskViewModel.toggle(val: val, task: TaskRequest(
                                        id: task.id,
                                        title: task.title,
                                        description: task.description,
                                        deadline: task.deadline ?? "",
                                        quadrant: task.quadrant.rawValue,
                                        isCompleted: val
                                    ))
                            }
                        } onDelete: { t in
                            Swift.Task {
                                await taskViewModel.delete(id: t.id)
                            }
                        }
                        .draggable(task.id.uuidString)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .frame(height: 350)
        .background(bgColor.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(
            color: Color.black.opacity(0.1),
            radius: 10,
            x: 0,
            y: 3
        )
        .addQuadrant(
            isPresented: $isAddPresented,
            title: $taskTitle,
            description: $taskDescription,
            quadrant: $taskQuadrant,
            deadline: $taskDeadline,
            datePicker: $taskDate,
            quadrantList: taskViewModel.quadrant
        ) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let deadline = formatter.string(from: taskDate)
            Swift.Task {
                await taskViewModel.add(
                    task: TaskRequest(
                        title: taskTitle,
                        description: taskDescription,
                        deadline: deadline,
                        quadrant: taskQuadrant
                    )
                )
            }
        }
        .dropDestination(for: String.self) { droppedId, location in
            Swift.Task {
                guard let idString = droppedId.first, let id = UUID(uuidString: idString) else {
                    return false
                }
                guard let q = Quadrant(rawValue: quadrant) else {
                    return false
                }
                let task = taskViewModel.tasks.filter({ $0.id == id }).first ?? nil
                await taskViewModel.move(
                    id: id,
                    quadrant: q,
                    task: TaskRequest(
                        id: id,
                        title: task?.title ?? "",
                        description: task?.description ?? "",
                        deadline: task?.deadline ?? "",
                        quadrant: q.rawValue,
                        isCompleted: task?.isCompleted
                    )
                )
                return true
            }
        }
    }
}

#Preview {
    QuadrantBox(
        bgColor: Color("Primary"),
        title: "Do First",
        description: "Urgent and Important",
        quadrant: "DO_FIRST",
        tasks: [
            Task(
                id: UUID(),
                title: "Tugas Vispro",
                description: "ALP Vispro android & backend",
                quadrant: .doFirst,
                isCompleted: false,
                userId: "1",
                deadline: "2026-04-21"
            )
        ])
    .environmentObject(TaskViewModel())
}
