//
//  Welcome_User.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-07.
//

import SwiftUI

struct Welcome_User: View {
 
    var body: some View {
    
        ZStack{
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
 

            ZStack {
                // Fond d'écran
                Image("logo1")
                    .opacity(0.8)

            }
            VStack {
                Spacer()
                
                Button(action: {
                    // Logique de connexion
 
                }) {
                    Text("Explore")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                        .padding(.horizontal, 32)
                }
                .padding(.top, 20)
                .shadow(color: .black, radius: 70, x: 1, y: 30)
                              
                Button(action: {
                    // Logique pour oublier le mot de passe
                }) {
                    Text("Welcome to EcoGuide Sign in or create your account")
                        .fontWeight(.thin)
                        .foregroundColor(.white)
                        .font(.caption)
                }
                .padding(.top, 5)
 
            }
        }
    }
    
}
struct Welcome_User_Previews: PreviewProvider {
    static var previews: some View {
        Welcome_User()
    }
}
