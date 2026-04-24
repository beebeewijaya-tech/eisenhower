//
//  HomeListTask.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 24/04/26.
//

import SwiftUI


struct ListTaskModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .padding()
            .frame(maxWidth: .infinity, minHeight: 50, alignment: .leading)
            .background(.white.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct ListTask: View {
    var task: Task
    var bgColor: Color
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top) {
                Toggle("", isOn: .constant(false))
                    .toggleStyle(AppToggle(bgColor: bgColor))
                
                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.caption)
                        .bold()
                }
                Spacer()
            }
            .padding(.bottom, 5)
            Text(task.description)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundStyle(.gray)
                .font(.caption)
                .padding(.bottom, 5)
            
            Text("Deadline: \(task.deadline ?? "")")
                .foregroundStyle(bgColor)
                .font(.system(size: 10))
                .bold()
        }
        .modifier(ListTaskModifier())
        .padding(.bottom, 10)
    }
}


#Preview {
    ListTask(
        task: Task(id: UUID(), title: "Tugas Vispro", description: "ALP Vispro android & backend", quadrant: .doFirst, isCompleted: false, userId: "1", deadline: "2026-04-21"),
        bgColor: Color("Primary")
    )
}
