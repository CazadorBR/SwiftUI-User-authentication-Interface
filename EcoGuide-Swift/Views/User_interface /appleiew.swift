//
//  appleiew.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-22.
//

import SwiftUI

struct appleiew: View {
 
    @StateObject var appleIdLogin = AppleIdLogin()

    
   
        
        var body: some View {
               VStack {
                   if appleIdLogin.isSignedIn {
                       Text("Connecté avec Apple ID")
                   } else {
                       SignInWithAppleButtonView()
                           .frame(width: 200, height: 44)
                           .onTapGesture {
                               appleIdLogin.signInWithApple()
                           }
                   }
               }
           }
       }

struct appleiew_Previews: PreviewProvider {
    static var previews: some View {
        appleiew()
    }
}
