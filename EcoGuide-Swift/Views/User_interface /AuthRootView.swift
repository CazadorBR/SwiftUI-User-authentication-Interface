//
//  AuthRootView.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-13.
//

import SwiftUI
enum ActiveAuthView {
    case forgetPassword
    case resetPassword
}

struct AuthRootView: View {
    @State private var activeView: ActiveAuthView = .forgetPassword
    
    var body: some View {
        switch activeView {
        case .forgetPassword:
            Forget_Password()(activeView: $activeView)
        case .resetPassword:
            r() // Supposons que cette vue n'a pas besoin de revenir à la vue précédente
        }
    }
}


struct AuthRootView_Previews: PreviewProvider {
    static var previews: some View {
        AuthRootView()
    }
}
