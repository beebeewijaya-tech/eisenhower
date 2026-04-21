//
//  LoginScreen.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 20/04/26.
//

import SwiftUI
import AlertToast

struct LoginScreen: View {
    // MARK: - Environment
    @Environment(Router.self) private var router
    
    // MARK: - State
    @State var email: String = ""
    @State var password: String = ""
    
    // MARK: ViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    
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
                
                AppButton(title: "Log in", type: .primary) {
                    Task {
                        await authViewModel.login(email: email, password: password)
                    }
                }
                
                Rectangle()
                    .fill(Color.black.opacity(0.2))
                    .frame(height: 1)
                    .padding(.vertical, 20)
                
                Text("Don't have an account? Sign up")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(Color("Primary"))
                    .onTapGesture {
                        router.navigate(path: .register)
                    }
            }
            .padding()
            .padding(.horizontal, 12)
        }
        .toast(isPresenting: $authViewModel.isError, alert: {
            AlertToast(
                type: .error(Color("Primary")),
                title: "Error",
                subTitle: authViewModel.err
            )
        })
        .toast(isPresenting: $authViewModel.isLoading, alert: {
            AlertToast(
                type: .loading,
            )
        })
    }
}


#Preview {
    LoginScreen()
        .environment(Router())
        .environmentObject(AuthViewModel())
}
