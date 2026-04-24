//
//  AppPicker.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 25/04/26.
//

import SwiftUI

struct AppPicker: View {
    @Binding var selection: String
    var label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption)
                .bold()
                .foregroundStyle(.black)
                .padding(.horizontal, 4)

            HStack {
                Text(selection)
                    .font(.body)
                    .foregroundStyle(.black)
                Spacer()
                Image(systemName: "chevron.up.chevron.down")
                    .foregroundStyle(Color("Primary"))
            }
            .padding(20)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("Secondary").opacity(0.7), lineWidth: 1)
            )
            .shadow(color: Color("Secondary").opacity(0.3), radius: 10, x: 0, y: 4)
        }
    }
}
