////
////  AppDelegate.swift
////  EcoGuide-Swift
////
////  Created by ben romdhane fedi on 2023-11-20.
////
//
//import Foundation
//import FacebookCore
//
//// AppDelegate pour les configurations traditionnelles d'UIKit
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        // Initialisation du SDK Facebook
//        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
//        return true
//    }
//
////    // Méthode pour iOS 12 et versions antérieures
////    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
////        return ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
////    }
////
//    // Méthode pour iOS 13 et versions ultérieures
//    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        ApplicationDelegate.shared.application(application, open: url, options: options)
//    }
//}
