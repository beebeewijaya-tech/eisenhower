//
//  RegisterScreen.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 21/04/26.
//

import SwiftUI
import AlertToast

struct RegisterScreen: View {
    // MARK: - AppStorage
    @AppStorage("token") private var token: String?
    
    // MARK: - Environment
    @Environment(Router.self) private var router
    
    // MARK: - State
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    
    // MARK: - ViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
        
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
                
                AppInput(text: $name, label: "Name", placeholder: "Your Name", type: .text)
                    .padding(.bottom, 12)

                AppInput(text: $email, label: "Email address", placeholder: "youremail@gmail.com", type: .text)
                    .padding(.bottom, 12)
                
                AppInput(text: $password, label: "Password", placeholder: "•••••••••••••", type: .password)
                    .padding(.bottom, 20)
                
                AppButton(title: "Create Account", type: .primary) {
                    Swift.Task {
                        await authViewModel.register(name: name, email: email, password: password)
                        
                        router.replaceAll(path: .login)
                    }
                }
                
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
            .toast(isPresenting: $authViewModel.isError) {
                AlertToast(
                    type: .error(Color("Primary")),
                    title: "Error",
                    subTitle: authViewModel.err
                )
            }
            .toast(isPresenting: $authViewModel.isLoading) {
                AlertToast(
                    type: .loading
                )
            }
        }
    }
}

#Preview {
    RegisterScreen()
        .environment(Router())
}
