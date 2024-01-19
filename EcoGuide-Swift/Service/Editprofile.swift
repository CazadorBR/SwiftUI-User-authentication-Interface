//
//  Editprofile.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-15.
//

import Foundation
class   Editprofile{
    let baseURL = "http://192.168.1.116:3000/"

    //_____________________________________________Edit Profile Logique__________________________________________________________________________

    func Editprofile(email:String,password: String, name: String, completion: @escaping (Bool, String) -> Void) {
        let url  = URL(string: baseURL + "EditProfile")!

//        let url = URL(string: "http://192.168.1.126:3000/EditProfile")!
        var request = URLRequest(url: url)
        print(url)
        request.httpMethod = "POST"
        if let accessToken = UserDefaults.standard.string(forKey: "tokenAuth") {
            print(accessToken)
            
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        print("Endpoint Headers : \(request.allHTTPHeaderFields ?? [:])")
        
        let body: [String: Any] = ["email": email,"password": password, "name": name]
        print(body)
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        do {
             let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
            
             if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("JSON String : \(jsonString)")
            }
            
        } catch {
            print("Error: \(error.localizedDescription)")
            completion(false, "Failed to create JSON body")
            return
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error.localizedDescription)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                completion(true, "Password has been successfully reset.")
            } else {
                completion(false, "Failed to reset password.")
            }
        }.resume()
    }
    //_____________________________________________Loggout Logique__________________________________________________________________________
    
    func logoutUser(token: String) {
        
        guard   let url  = URL(string: baseURL + "logout")else {

//        guard let url = URL(string: "http://192.168.1.126:3000/logout") else {
            print("URL invalide")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let accessToken = UserDefaults.standard.string(forKey: "tokenAuth") {
            print(accessToken)
            
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erreur de requête : \(error)")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Réponse serveur non valide.")
                return
            }

            if let mimeType = response.mimeType, mimeType == "application/json", let data = data {
                let stringData = String(data: data, encoding: .utf8)
                print("Réponse : \(stringData ?? "Pas de données")")
            }
        }

        task.resume()
    }

    //_____________________________________________User Details Logique__________________________________________________________________________

    func fetchUserDetails(completion: @escaping (Result<UserDetails, Error>) -> Void) {

        guard   let url  = URL(string: baseURL + "userdetails")else {
//         guard let url = URL(string: "http://192.168.1.126:3000/userdetails") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        if let accessToken = UserDefaults.standard.string(forKey: "tokenAuth") {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                 completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
//            print(httpResponse)
            // Ajouter cette ligne pour imprimer les données brutes
               if let jsonString = String(data: data, encoding: .utf8) {
                   print("Réponse JSON brute: \(jsonString)")
               }
            do {
                       let userDetails = try JSONDecoder().decode(UserDetails.self, from: data)
                        print(userDetails)
                       completion(.success(userDetails))
                   } catch {
                       completion(.failure(error))
                   }
               }.resume()
           }
    
//    func uploadProfileImage(image: UIImage, completion: @escaping (Result<Bool, Error>) -> Void) {
//        guard let imageData = image.jpegData(compressionQuality: 0.5),
//              let url = URL(string: "http://192.168.31.248:3000/editprofileimage") else {
//            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL or Image Data"])))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        // Ajouter le token d'authentification
//        if let accessToken = UserDefaults.standard.string(forKey: "tokenAuth") {
//            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        }
//
//        // Préparer la requête multipart/form-data
//        let boundary = "Boundary-\(UUID().uuidString)"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//        var body = Data()
//        body.append("--\(boundary)\r\n")
//        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n")
//        body.append("Content-Type: image/jpeg\r\n\r\n")
//        body.append(imageData)
//        body.append("\r\n")
//        body.append("--\(boundary)--\r\n")
//
//        request.httpBody = body
//
//        // Envoyer la requête
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
//                return
//            }
//
//            // Vous pouvez personnaliser cette partie en fonction de la réponse attendue de votre API
//            completion(.success(true))
//        }.resume()
//    }

    


}
