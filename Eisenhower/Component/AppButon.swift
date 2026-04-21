//
//  AppButon.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 20/04/26.
//

import SwiftUI

enum ButtonType {
    case primary
    case secondary
    
    
    var backgroundColor: Color {
        switch self {
        case .primary:
            return Color("Primary")
        case .secondary:
            return Color("White")
        }
    }
    
    var textColor: Color {
        switch self {
        case .primary:
            return Color("White")
        case .secondary:
            return Color("Primary")
        }
    }
    
    var borderColor: Color {
        switch self {
        case .primary:
            return .clear
        case .secondary:
            return Color("Primary")
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .primary:
            return 0
        case .secondary:
            return 2
        }
    }
}



struct AppButton: View {
    var title: String
    var type: ButtonType
    var action: () -> Void = {}
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.callout)
                .tracking(0.5)
                .foregroundStyle(type.textColor)
                .bold()
                .frame(maxWidth: .infinity, minHeight: 50)
                .padding(.vertical, 8)
                .background(type.backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(type.borderColor, lineWidth: type.borderWidth)
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: type.backgroundColor.opacity(0.4), radius: 10, x: 0, y: 3)
        }
    }
}


#Preview {
    AppButton(title: "Submit", type: .secondary)
}
