////
////  AppleIdLogin.swift
////  EcoGuide-Swift
////
////  Created by ben romdhane fedi on 2023-11-21.
////
//
//import Foundation
//import AuthenticationServices
//
//extension AppleIdLogin: ASAuthorizationControllerDelegate {
//    func signInWithApple() {
//        let request = ASAuthorizationAppleIDProvider().createRequest()
//        request.requestedScopes = [.fullName, .email]
//
//        let controller = ASAuthorizationController(authorizationRequests: [request])
//        controller.delegate = self
//        controller.performRequests()
//    }
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            let userIdentifier = appleIDCredential.user
//            let fullName = appleIDCredential.fullName
//            let email = appleIDCredential.email
//
//            // Envoyer ces informations à votre serveur Node.js
//        }
//    }
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        // Gérer l'erreur
//    }
//}
