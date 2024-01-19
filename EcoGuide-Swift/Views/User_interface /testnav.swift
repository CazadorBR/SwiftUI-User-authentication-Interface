//
//  testnav.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-16.
//

import SwiftUI
import LocalAuthentication

struct testnav: View {
    @State private var isLinkActive = false
    @State private var isLoggingIn = false // Variable d'état pour contrôler la visibilité du ProgressView
    
    @State private var isLoading = false

    @State private var isAuthenticated = false
    @State private var isAuthenticating = false

      var body: some View {
          
          
          
          if isAuthenticated {
              Text("Authentication Successful")
                  .font(.title)
                  .padding()
                  .background(Color.green)
                  .foregroundColor(.white)
                  .cornerRadius(10)
          } else {
              Button(action: {
                  authenticateUser()
              }) {
                  if isAuthenticating {
                      ProgressView()
                          .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                          .frame(width: 100, height: 100)
                          .scaleEffect(1.5)
                          .padding(20)
                          .foregroundColor(.red)
                          .opacity(0.8)
                          .animation(.easeInOut)
                  } else {
                      Text("Start Loading")
                          .foregroundColor(.white)
                          .padding()
                          .background(Color.blue)
                          .cornerRadius(20)
                  }
              }
          }
      }

      private func authenticateUser() {
          isAuthenticating = true
          let context = LAContext()
          var error: NSError?

          if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
              let reason = "Authenticate to access this feature"

              context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                  DispatchQueue.main.async {
                      isAuthenticating = false
                      isAuthenticated = success
                  }
              }
          } else {
              // Gérer le cas où Touch ID/Face ID n'est pas disponible ou configuré
              isAuthenticating = false
          }
      }
  }
  


struct SecondView: View {
    var body: some View {
        Text("Seconde Vue")
            .navigationBarBackButtonHidden(true)
    }
}
struct testnav_Previews: PreviewProvider {
    static var previews: some View {
        testnav()
    }
}
