//
//  File.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-13.
//

import Foundation
enum ActiveAuthView {
    case forgetPassword
    case resetPassword
}
struct AuthRootView: View {
    @State private var activeView: ActiveAuthView = .forgetPassword
    
    var body: some View {
        switch activeView {
        case .forgetPassword:
            ForgetPasswordView(activeView: $activeView)
        case .resetPassword:
            ResetPasswordView() // Supposons que cette vue n'a pas besoin de revenir à la vue précédente
        }
    }
}
