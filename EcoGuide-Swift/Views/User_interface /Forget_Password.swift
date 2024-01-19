//
//  Forget_Password.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-08.
//

import SwiftUI

enum RecoveryOption {
    case email, sms
}
let authService = forget_password()

struct Forget_Password: View {
    @State private var email: String = ""
    @State private var showingAlert = false
    @State private var telephone: String = ""
    @State private var navigateToNextView = false
    @State private var recoveryOption: RecoveryOption = .email
    @State private var sheetToggleView = false

       var body: some View {
         
           VStack {
               Spacer()
//                   .navigationBarBackButtonHidden(true)

                Image(systemName: "shared.with.you")
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(width: 100, height: 90)
                   .foregroundColor(.blue)
               
               Spacer()
                Text("Forget Password ?")
                   .font(.largeTitle)
                   .fontWeight(.semibold)
                   .opacity(0.7)

                Text("Enter your email associated with your account")
                   .font(.body)
                   .padding(.top, 4)
               
               Text("We will email you a code to reset your password")
                   .font(.footnote)
                   .foregroundColor(.gray)
                   .padding(.top, 2)
               
               
               Text("Choose your recovery method")
                             .font(.headline)
                             .padding(.top, 20)
               
               
               Picker("Recovery Method", selection: $recoveryOption) {
                   Text("Email").tag(RecoveryOption.email)
                   Text("SMS").tag(RecoveryOption.sms)
               }
               .pickerStyle(SegmentedPickerStyle())
               .padding()
               if recoveryOption == .email {
                              TextField("Email", text: $email)
                                  .padding()
                                  .background(Color(.systemGray6))
                                  .cornerRadius(10)
                                  .padding(.horizontal)
                                  .keyboardType(.emailAddress)
                                  .autocapitalization(.none)
                          } else {
                              TextField("Phone Number", text: $telephone)
                                  .padding()
                                  .background(Color(.systemGray6))
                                  .cornerRadius(10)
                                  .padding(.horizontal)
                                  .keyboardType(.phonePad)
                                  .autocapitalization(.none)
                          }

               
               
 
               Button(action: {
                       self.sheetToggleView.toggle()
                    if recoveryOption == .email{
                                         authService.forgetpassword(email: self.email  ) { result in
                                             DispatchQueue.main.async {
                                                 switch result {
                                                 case .success(let token):
                                               print("Code wes sent succefully: \(token)")
                                                     self.showingAlert = true
                                                     
                                                 case .failure(let error):
                                                     print("An error occurred while sending code: \(error.localizedDescription)")
                                                     self.showingAlert = true
                                                 }
                                             }
                                         }
                   }else{
                       
                    authService.forgetpasswordsms(telephone: self.telephone  ) { result in
                                    DispatchQueue.main.async {
                                                 switch result {
                                                 case .success(let code):
                                                     print("Code wes sent succefully: \(code)")
                                                     
                                                     self.showingAlert = true
                                                     
                                                 case .failure(let error):
                                                     print("An error occurred while sending code: \(error.localizedDescription)")
                                                     self.showingAlert = true
                                                 }
                                             }
                                         }
                   }
               })
               {
                   
                   Text("Send Code")
                       .foregroundColor(.white)
                       .padding()
                       .frame(maxWidth: .infinity)
                       .background(Color.blue)
                       .cornerRadius(10)
                       .padding(.horizontal)
                       .shadow(color: .black, radius: 95, x: 1, y: 40)

               }
               .padding(.top, 20)
//               shadow(color: .black, radius: 70, x: 1, y: 30)
               .alert(isPresented: $showingAlert) {
                   
                   Alert(
                       title: Text("Code has been sent"),
                       message: Text("Thank you for checking your Mail to get your verification Code."),
                       dismissButton: .default(Text("OK"), action: {
                           navigateToNextView = true
                       })
                   )
            }
               .sheet(isPresented:$sheetToggleView ){
                          OTP()
                      }
            }
           
           .padding()
           Spacer()
       }
    
   }


struct Forget_Password_Previews: PreviewProvider {
    static var previews: some View {
        Forget_Password()
    }
    
}
 
