//
//  HomeExtension.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 24/04/26.
//

import SwiftUI

extension View {
    func addQuadrant(
        isPresented: Binding<Bool>,
        title: Binding<String>,
        description: Binding<String>,
        quadrant: Binding<String>,
        deadline: Binding<String>,
        datePicker: Binding<Date>,
        quadrantList: [QuadrantItem],
        action: @escaping () -> Void
    ) -> some View {
        self.sheet(isPresented: isPresented) {
            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    AppInput(text: title, label: "Task Title", placeholder: "Enter your task title", type: .text)
                        .padding(.bottom, 8)
                    AppInput(text: description, label: "Task Description", placeholder: "Enter your description of your task", type: .text)
                        .padding(.bottom, 8)
                    
                    Menu {
                        ForEach(quadrantList.enumerated(), id: \.element.id) { idx, q in
                            Button(q.type) {
                                quadrant.wrappedValue = q.type
                            }
                        }
                    } label: {
                        AppPicker(selection: quadrant, label: "Task Quadrant")
                    }
                    .padding(.bottom, 8)
                    
                    DatePicker("Deadlines", selection: datePicker, in: Date.now..., displayedComponents: .date)
                        .padding(.bottom, 8)
                    
                    AppButton(title: "Add Task", type: .primary) {
                        action()
                    }
                    
                    Spacer()
                }
                .padding()
                .padding(.top, 20)
                .frame(maxWidth: .infinity)
                .presentationDetents([.large, .medium])
                .presentationDragIndicator(.visible)
            }
        }
    }
}
