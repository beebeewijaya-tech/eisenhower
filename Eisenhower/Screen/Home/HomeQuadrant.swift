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
    var bgColor: Color
    var title: String
    var description: String
    var tasks: [Task]
    
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
                AppImageButton(image: "plus")
            }
            .padding(.bottom, 20)
            
            VStack {
                List {
                    ForEach(tasks) { task in
                        ListTask(task: task, bgColor: bgColor)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 300, alignment: .topLeading)
        .background(bgColor.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(
            color: Color.black.opacity(0.1),
            radius: 10,
            x: 0,
            y: 3
        )
    }
}

#Preview {
    QuadrantBox(
        bgColor: Color("Primary"),
        title: "Do First",
        description: "Urgent and Important",
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
}
