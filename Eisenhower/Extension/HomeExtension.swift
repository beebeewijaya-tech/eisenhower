//
//  HomeExtension.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 25/04/26.
//

import SwiftUI

extension View {
    func addAITaskSheet(
        isPresented: Binding<Bool>,
        text: Binding<String>,
        isLoading: Bool,
        action: @escaping () -> Void
    ) -> some View {
        self.sheet(isPresented: isPresented) {
            VStack {
                Text("What task are you currently focused on?")
                    .font(.body)
                    .bold()
                
                Text("Prompt here and we will generate task for you!")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.bottom, 20)
                
                AppInput(text: text, label: "Prompt", placeholder: "What kind of tasks  ...", type: .textarea, lineLimit: 8)
                    .padding(.bottom, 20)
                
                if isLoading {
                    ProgressView()
                } else {
                    AppButton(title: "Generate", type: .primary) {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        action()
                    }
                }
            }
            .padding()
        }
    }
}
