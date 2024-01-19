//
//  OTP.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-08.
//

import SwiftUI

struct OTP: View {
    @State private var code = ""
    @State private var timeRemaining = 53
    @State private var nav = false
    @State private var sheetToggleView = false

    let reset = Reset_password()

       let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

       var body: some View {
           VStack {
                Image(systemName: "clock.badge.checkmark.fill")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 150, height: 150)
                  .foregroundColor(.blue)
                  .opacity(0.4)
               // Title
               Text("Forgot Password")
                   .font(.title)
                   .fontWeight(.bold)
               
               // Message
               Text("Code Has Been sent to +1 111 **** 99")
                   .font(.body)
                   .foregroundColor(.gray)
                   .padding(.vertical)
               
               // Code Input Fields
               HStack(spacing: 20)
               {
                        TextField("code", text: $code)
                           .frame(width: 40, height: 45)
                           .background(Color(.systemGray6))
                           .multilineTextAlignment(.center)
                           .keyboardType(.numberPad)
                           .cornerRadius(10)
                           
                    
               }
               .padding()
               
               // Resend Code Timer
               if timeRemaining > 0 {
                   Text("Resend code in \(timeRemaining)s")
                       .font(.caption)
                       .foregroundColor(.blue)
                       .onReceive(timer) { _ in
                           if timeRemaining > 0 {
                               timeRemaining -= 1
                           }
                       }
               } else {
                   Button(action: {
                       // Action to resend the code
                       // Reset the timer
                       // save code in prefs
                       // fetch payload from token
//                       if let token = UserDefaults.standard.string(forKey: "tokenverificationcode") {
//                           print("Token: \(token)")
//                           if let payload = reset.decodeJWT(token: token) {
//                                  // Affichez les informations de payload
//                               print("Payload:", payload)
//                              } else {
//                                  print("Impossible de décoder le token.")
//                              }
//                       } else {
//                           print("Token not found")
//                       }
//                       if $code == payload.code {
//                           nav : true
//                       }
//                       compare code (input) with code (payload token) if true navigate to reset-password
                       timeRemaining = 53
                   }) {
                       Text("Resend code")
                           .foregroundColor(.blue)
                   }
               }
               

               // Verify Button
               Button(action: {
                   self.sheetToggleView.toggle()
                   UserDefaults.standard.set(code,forKey:"CodeInput")

                   // Action to verify the code
               }) {
                   Text("Verify")
                       .foregroundColor(.white)
                       .frame(maxWidth: .infinity)
                       .padding()
                       .background(Color.blue)
                       .cornerRadius(10)
                       .padding(.horizontal)
                       .shadow(color: .black, radius: 95, x: 1, y: 40)

               }
               .padding(.bottom)
               .sheet(isPresented:$sheetToggleView ){
                          Reset_Password()
                      }
           }
           .padding()
       }
   }

 

struct OTP_Previews: PreviewProvider {
    static var previews: some View {
        OTP()
    }
}
