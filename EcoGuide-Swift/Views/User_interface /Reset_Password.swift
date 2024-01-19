//
//  Reset_Password.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-08.
//

import SwiftUI

struct Reset_Password: View {
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var rememberMe = false
    @State private var navigatingToResetPassword = false
    let resetPWD = Reset_password()
    @State private var resultMessage = ""
    @State private var message: String = ""
    @State private var showingAlert = false

      var body: some View {
 
          VStack {
              // Title
             

              Image(systemName: "person.badge.shield.checkmark.fill")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(height: 150)
                  .foregroundColor(.blue)
                  .padding()
                  .opacity(0.4)
              Text("Resest  your Password")
                  .font(.title)
                  .fontWeight(.bold)
                  .padding()
                  .opacity(0.7)

              VStack(spacing: 15) {
                  SecureField("Create Your New Password", text: $newPassword)
                      .padding()
                      .background(Color(.systemGray6))
                      .cornerRadius(10)

                  SecureField("Confirm Your New Password", text: $confirmPassword)
                      .padding()
                      .background(Color(.systemGray6))
                      .cornerRadius(10)
              }
              .padding()

              Toggle(isOn: $rememberMe) {
                  Text("Remember Me")
              }
              .padding()
              .foregroundColor(.blue)


               Button(action: {
                            
//            let token = UserDefaults.standard.string(forKey: "tokenverificationcode") ?? ""
            let code = UserDefaults.standard.string(forKey: "CodeInput") ?? ""
                            
                print(code)
            if !code.isEmpty {
                resetPWD.resetPassword(password: self.newPassword, code: code) { success, responseMessage in
               DispatchQueue.main.async {
                   self.message = responseMessage
                   self.showingAlert = true

                        }
                    }
            } else {
                self.message = "  code not found"
            }
              }) {
                  Text("Reset Password")
                      .foregroundColor(.white)
                      .frame(maxWidth: .infinity)
                      .padding()
                      .background(Color.blue)
                      .cornerRadius(10)
              }
              .padding(.horizontal)
              .shadow(color: .black, radius: 95, x: 1, y: 40)
 
              .alert(isPresented: $showingAlert) {
                  
                  Alert(
                      title: Text("Succes"),
                      message: Text("You are Successfully reseted your password"),
                      dismissButton: .default(Text("OK"))
                  )
              }
              
              
              Spacer()
          }
          .padding()
      }
  }

struct Reset_Password_Previews: PreviewProvider {
    static var previews: some View {
        Reset_Password()
    }
}
