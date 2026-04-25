//
//  HomeListTask.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 24/04/26.
//

import SwiftUI


struct ListTaskModifier: ViewModifier {
    var bgColor: Color
    var isComplete: Bool

    func body(content: Content) -> some View {
        content
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .padding()
            .frame(maxWidth: .infinity, minHeight: 50, alignment: .leading)
            .background(isComplete ? bgColor.opacity(0.5) : .white.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct ListTask: View {
    var task: Task
    var bgColor: Color
    var onToggle: (Bool, Task) -> Void = {_, _ in }
    var onDelete: (Task) -> Void = {_ in }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top) {
                Toggle("", isOn: Binding(
                    get: { task.isCompleted },
                    set: { onToggle($0, task) }
                ))
                    .toggleStyle(AppToggle(bgColor: bgColor))
                
                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.caption)
                        .bold()
                        .strikethrough(task.isCompleted)
                }
                Spacer()
            }
            .padding(.bottom, 5)
            Text(task.description)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundStyle(.gray)
                .font(.caption)
                .padding(.bottom, 5)
                .strikethrough(task.isCompleted)
            
            Text("Deadline: \(task.deadline ?? "")")
                .foregroundStyle(bgColor)
                .font(.system(size: 10))
                .bold()
                .strikethrough(task.isCompleted)
        }
        
        .modifier(ListTaskModifier(bgColor: bgColor, isComplete: task.isCompleted))
        .padding(.bottom, 10)
        .overlay(alignment: .bottomTrailing) {
            AppImageButton(image: "trash", width: 25) {
                onDelete(task)
            }
        }
        .padding(.bottom, 20)
    }
}


#Preview {
    ListTask(
        task: Task(id: UUID(), title: "Tugas Vispro", description: "ALP Vispro android & backend", quadrant: .doFirst, isCompleted: false, userId: "1", deadline: "2026-04-21"),
        bgColor: Color("Primary")
    )
}
