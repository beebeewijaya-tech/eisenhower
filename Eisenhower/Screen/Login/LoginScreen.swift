//
//  LoginScreen.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 20/04/26.
//

import SwiftUI


struct LoginScreen: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("White")
                .ignoresSafeArea()
            
            VStack {
                VStack(alignment: .leading) {
                    Text("Welcome to QuadTask")
                        .font(.title)
                        .foregroundStyle(Color.black)
                        .bold()
                    Text("Sign in to your account")
                        .font(.headline)
                        .foregroundStyle(Color.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 30)
                .padding(.bottom, 20)
                
                AppInput(text: $email, label: "Email address", placeholder: "youremail@gmail.com", type: .text)
                    .padding(.bottom, 12)

                AppInput(text: $password, label: "Password", placeholder: "•••••••••••••", type: .password)
                    .padding(.bottom, 20)

                AppButton(title: "Log in", type: .primary)
            }
            .padding()
            .padding(.horizontal, 12)
        }
    }
}


#Preview {
    LoginScreen()
}
