//
//  AppleIdLogin.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-22.
//

import Foundation
import AuthenticationServices

class AppleIdLogin: NSObject, ASAuthorizationControllerDelegate,ObservableObject {
    @Published var isSignedIn: Bool = false // Utilisez @Published pour publier les changements de cette propriété

    func signInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email

            // Envoyer ces informations à votre serveur Node.js
            DispatchQueue.main.async {
                self.isSignedIn = true
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Gérer l'erreur
    }
}
