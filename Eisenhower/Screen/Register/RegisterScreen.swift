//
//  RegisterScreen.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 21/04/26.
//

import SwiftUI

struct RegisterScreen: View {
    // MARK: - Environment
    @Environment(Router.self) private var router
    
    // MARK: - State
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("White")
                .ignoresSafeArea()
            
            VStack {
                VStack(alignment: .leading) {
                    Text("Join QuadTask")
                        .font(.title)
                        .foregroundStyle(Color.black)
                        .bold()
                    Text("Fill the information details")
                        .font(.headline)
                        .foregroundStyle(Color.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 30)
                .padding(.bottom, 20)
                
                AppInput(text: $email, label: "Name", placeholder: "Your Name", type: .text)
                    .padding(.bottom, 12)

                AppInput(text: $email, label: "Email address", placeholder: "youremail@gmail.com", type: .text)
                    .padding(.bottom, 12)
                
                AppInput(text: $password, label: "Password", placeholder: "•••••••••••••", type: .password)
                    .padding(.bottom, 20)
                
                AppButton(title: "Create Account", type: .primary)
                
                Rectangle()
                    .fill(Color.black.opacity(0.2))
                    .frame(height: 1)
                    .padding(.vertical, 20)
                
                Text("Already have an account? Log in")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(Color("Primary"))
                    .onTapGesture {
                        router.pop()
                    }
            }
            .padding()
            .padding(.horizontal, 12)
        }
    }
}

#Preview {
    RegisterScreen()
}
