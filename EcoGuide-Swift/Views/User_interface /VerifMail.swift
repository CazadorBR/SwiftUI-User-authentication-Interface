////
////  VerifMail.swift
////  EcoGuide-Swift
////
////  Created by ben romdhane fedi on 2023-11-07.
////
//
//import SwiftUI
//
//struct VerifMail: View {
//    @State private var navigateToLogin = false
//
//    var body: some View {
//
//
//         NavigationView{
//             Button("aller vers"){
//
//             }
//         }
//          
//                    Button(action: {
//                        let reset = Reset_password()
////                         self.navigateToLogin .toggle()
//                        if let token = UserDefaults.standard.string(forKey: "tokenverificationcode") {
//                            print("Token: \(token)")
//                            if let payload = reset.decodeJWT(token: token) {
//                                   // Affichez les informations de payload
//                                print("Payload:", payload.keys)
//                               } else {
//                                   print("Impossible de décoder le token.")
//                               }
//                        } else {
//                            print("Token not found")
//                        }
//
//                    }) {
//                        Text("Verify Mail")
//                            .fontWeight(.bold)
//                            .foregroundColor(.white)
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .cornerRadius(20)
//                            .padding(.horizontal, 32)
//                    }
////                    .sheet(isPresented:$navigateToLogin ){
////                               Reset_Password()
////                           }
//
//
//
//
//            }
//        }
//
//
//
//
//
////    var body: some View {
////            VStack {
////                Text("Mail Verification")
////                    .font(.largeTitle)
////                    .fontWeight(.semibold)
////                    .padding(.top)
////
////                Spacer()
////
////                // The checkmark circle
////                Image(systemName: "checkmark.circle.fill")
////                    .resizable()
////                    .aspectRatio(contentMode: .fit)
////                    .frame(width: 720, height: 270)
////                    .foregroundColor(Color.blue)
////                Spacer()
////                Text("We should verify your Email")
////                    .font(.headline)
////                    .foregroundColor(.secondary)
////                    .padding(.top, 8)
////
////                Spacer()
////
////                // Verify button
////                Button(action: {
////                    // Logique de connexion
////
////                }) {
////                    Text("Explore")
////                        .fontWeight(.bold)
////                        .foregroundColor(.white)
////                        .frame(minWidth: 0, maxWidth: .infinity)
////                        .padding()
////                        .background(Color.blue)
////                        .cornerRadius(20)
////                        .padding(.horizontal, 32)
////                }
////                .padding(.top, 20)
////                .shadow(color: .black, radius: 70, x: 1, y: 30)
////            }
////            .frame(maxWidth: .infinity, maxHeight: .infinity)
////            .background(Color(.systemGray6)) // Use an appropriate system color for background
////            .edgesIgnoringSafeArea(.all)
////        }
////    }
////
//
//struct VerifMail_Previews: PreviewProvider {
//    static var previews: some View {
//        VerifMail()
//    }
//}
