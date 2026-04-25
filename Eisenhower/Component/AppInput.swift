//
//  AppInput.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 21/04/26.
//

import SwiftUI

enum InputField {
    case text
    case password
    case textarea
    
    @ViewBuilder
    func inputField(_ placeholder: String, text: Binding<String>) -> some View {
        switch self {
        case .text:
            TextField(placeholder, text: text)
        case .textarea:
            TextField(placeholder, text: text, axis: .vertical)
        case .password:
            SecureField(placeholder, text: text)
        }
    }
}

struct AppInput: View {
    @Binding var text: String
    var label: String
    var placeholder: String
    var type: InputField
    var lineLimit: Int = 5
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption)
                .bold()
                .padding(.horizontal, 4)

            type.inputField(placeholder, text: $text)
                .font(.body)
                .padding(20)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            Color("Secondary").opacity(0.7),
                            lineWidth: 1
                        )
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(
                    color: Color("Secondary").opacity(0.3),
                    radius: 10,
                    x: 0,
                    y: 4
                )
                .lineLimit(lineLimit)
        }
    }
}


#Preview {
    AppInput(text: .constant(""), label: "Email", placeholder: "Email Address", type: .text)
}
