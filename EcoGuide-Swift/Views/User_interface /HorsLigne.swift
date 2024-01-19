//
//  HorsLigne.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-22.
//

import SwiftUI
import Network

struct HorsLigne: View {
    @State private var isOnline = true
    @State private var showingSnackbar = false

     var body: some View {
         ZStack {
             
             Color.white.edgesIgnoringSafeArea(.all)
             VStack {
                 
                 if isOnline {
//                     Text("Vous êtes en ligne")
//                         .foregroundColor(.green)
                 } else {
                     
                     Text("Vous êtes hors ligne")
                         .foregroundColor(.red)
                 }
             }
             .onAppear {
                 startMonitoring()
             }

             if !isOnline {
                 VStack {
                     SnackbarView(text: "Vous êtes hors ligne") // Vue personnalisée pour le snackbar
                         .background(Color.gray.opacity(0.9))
                         .foregroundColor(Color.white)
                         .transition(.move(edge: .top))
                     Spacer()
                 }
                 .animation(.default, value: showingSnackbar)
                 .onAppear {
                     showingSnackbar = true
                     DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                         showingSnackbar = false
                     }
                 }
             }
         }
     }

     func startMonitoring() {
         let monitor = NWPathMonitor()
         monitor.pathUpdateHandler = { path in
             DispatchQueue.main.async {
                 isOnline = path.status == .satisfied
                 showingSnackbar = !isOnline
             }
         }
         let queue = DispatchQueue(label: "NetworkMonitor")
         monitor.start(queue: queue)
     }
 }

 struct SnackbarView: View {
     var text: String

     var body: some View {
         Text(text)
             .padding()
             .frame(maxWidth: .infinity)
     }
 }

struct HorsLigne_Previews: PreviewProvider {
    static var previews: some View {
        HorsLigne()
    }
}
