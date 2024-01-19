//
//  TestUserDetails.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-17.
//

import SwiftUI
let edit = Editprofile()
struct TestUserDetails: View {
    @State private var userDetails: UserDetails?
        @State private var isLoading = false
        @State private var errorMessage: String?
    var body: some View {
        VStack {
                    // Affichez les détails de l'utilisateur si disponibles
                    if let userDetails = userDetails {
                        Text("Nom: \(userDetails.name)")
                        Text("Email: \(userDetails.email)")
                        Text("Téléphone: \(userDetails.telephone)")
                     }

                    // Affichez un message d'erreur si présent
                    if let errorMessage = errorMessage {
                        Text("Erreur: \(errorMessage)")
                            .foregroundColor(.red)
                    }

                    // Bouton pour charger les détails de l'utilisateur
                    Button("Charger les détails de l'utilisateur") {
                        isLoading = true
                        errorMessage = nil

                        edit.fetchUserDetails { result in
                            DispatchQueue.main.async {
                                isLoading = false
                                switch result {
                                case .success(let fetchedUserDetails):
                                    self.userDetails = fetchedUserDetails
                                case .failure(let error):
                                    self.errorMessage = error.localizedDescription
                                }
                            }
                        }
                    }

                    // Affichez un indicateur de chargement si nécessaire
                    if isLoading {
                        ProgressView()
                    }
                }
                .padding()
            }
        }

struct TestUserDetails_Previews: PreviewProvider {
    static var previews: some View {
        TestUserDetails()
    }
}
