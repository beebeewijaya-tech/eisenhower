//
//  AppAvatar.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 25/04/26.
//

import SwiftUI
import Lottie

struct AppAvatar: View {
    var avatar: String
    
    var body: some View {
        LottieView(animation: .named(avatar))
            .playing()
            .looping()
            .frame(height: 300)
    }
}


#Preview {
    AppAvatar(avatar: "Process")
}
