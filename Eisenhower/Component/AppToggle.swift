//
//  AppToggle.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 24/04/26.
//

import SwiftUI

struct AppToggle: ToggleStyle {
    var bgColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundStyle(configuration.isOn ? bgColor : .secondary)
                    .padding(0)
                configuration.label
            }
        }
        .padding(.trailing, -10)
        .buttonStyle(.plain)
    }
}


#Preview {
    VStack {
        Toggle("", isOn: .constant(true))
            .toggleStyle(AppToggle(bgColor: Color("Primary")))
    }
}
