//
//  EcoGuide_SwiftApp.swift
//  EcoGuide-Swift
//
//  Created by Torkhani fara on 6/11/2023.
//

import SwiftUI
//import FacebookCore
 


@main
struct EcoGuide_SwiftApp: App {
 
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.string(forKey: "tokenAuth") != nil {
                ProfileView()
            }else{
                Register()

            }
//            HorsLigne()
 
         }
    }
}
 
