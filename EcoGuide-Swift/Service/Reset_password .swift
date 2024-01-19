//
//  Reset_password .swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-10.
//

import Foundation
struct ResetPasswordRequest: Codable {
    let password: String
    let code: String
}

struct ResetPasswordResponse: Codable {
    let message: String
    // Ajoutez d'autres champs selon la réponse de votre API
}
class Reset_password {
    let baseURL = "http://192.168.1.116:3000/"
 
    
      func resetPassword(password: String, code: String, completion: @escaping (Bool, String) -> Void) {
          let url  = URL(string: baseURL + "reset-password")!

//          let url = URL(string: "http://192.168.1.126:3000/reset-password")!
          var request = URLRequest(url: url)
          print(url)
          request.httpMethod = "POST"
          if let accessToken = UserDefaults.standard.string(forKey: "tokenverificationcode") {
              print(accessToken)

              request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
              request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
          print("Endpoint Headers : \(request.allHTTPHeaderFields ?? [:])") // Ajouté pour le débogage

          let body: [String: Any] = ["password": password, "code": code]
          print(body)
          request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
          do {
                  // Conversion du dictionnaire en JSON
                  let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
                  request.httpBody = jsonData
                  
                  // Impression du JSON pour le débogage
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
  }
    
//    func resetPassword(password: String, code: String, completion: @escaping (Result<Data, Error>) -> Void) {
//        // Define the API endpoint URL
//        let apiUrl = URL(string: "http://192.168.1.129:3000/reset-password")!
//
//        // Create a JSON dictionary with the password and code
//        let jsonBody: [String: Any] = [
//            "password": password,
//            "code": code
//        ]
//
//        // Convert the JSON dictionary to Data
//        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody) else {
//            completion(.failure(NSError(domain: "Invalid JSON data", code: 0, userInfo: nil)))
//            return
//        }
//
//        // Create a URLRequest with the API URL
//        var request = URLRequest(url: apiUrl)
//
//        // Set the HTTP method to POST
//        request.httpMethod = "POST"
//
//        // Set the request body to the JSON data
//        request.httpBody = jsonData
//
//        // Set the Content-Type header to indicate JSON data
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        // Add the Authorization header if you have a token
//        if let accessToken = UserDefaults.standard.string(forKey: "tokenverificationcode") {
//             request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        }
//        // Create a URLSessionDataTask to send the request
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
//                return
//            }
//
//            completion(.success(data))
//        }
//
//        // Start the URLSessionDataTask
//        task.resume()
//    }
//    func resetPassword(password: String, code: String, completion: @escaping (Bool, Error?) -> Void) {
//        let url = URL(string: "http://192.168.1.129:3000/reset-password")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        // Fetch the token from UserDefaults
//        if let token = UserDefaults.standard.string(forKey: "tokenverificationcode") {
//            // print("Token: \(token)")
//            // Add the token to the request header
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//
//            let requestBody: [String: Any] = [
//                "password": password,
//                "code": code,
//            ]
//
//            do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
//            } catch {
//                print("Erreur lors de la création des données JSON: \(error)")
//                return
//            }
//
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                if let error = error {
//                    print("Erreur lors de la requête: \(error)")
//                } else if let data = data {
//                    do {
//                        if let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                            if let message = responseJSON["message"] as? String {
//                                print("Réponse du serveur: \(message)")
//                                // Mettez à jour l'interface utilisateur en conséquence, par exemple, affichez un message de succès.
//                            } else {
//                                print("Réponse du serveur ne contient pas de message valide.")
//                            }
//                        } else {
//                            print("Réponse du serveur n'est pas un objet JSON valide.")
//                        }
//                    } catch {
//                        print("Erreur lors de la conversion de la réponse JSON: \(error)")
//                    }
//                }
//            }.resume()
//
            
            
            //
            //    if let valeur = UserDefaults.standard.string(forKey: "tokenverificationcodesms") {
            //        print(valeur)
            //    }
            
            //    func Reset_PWD(email: String, completion: @escaping (Result<String, Error>) -> Void) {
            //        guard let url = URL(string: "http://192.168.1.129:3000/reset-password") else {
            //            completion(.failure(URLError(.badURL)))
            //            return
            //        }
            //
            //        var request = URLRequest(url: url)
            //        request.httpMethod = "POST"
            //
            //        let parameters: [String: Any] = [
            //            "email": email,
            //         ]
            //
            //        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //
            //        let session = URLSession.shared
            //        let task = session.dataTask(with: request) { data, response, error in
            //            if let error = error {
            //                completion(.failure(error))
            //                return
            //            }
            //
            //            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            //                completion(.failure(URLError(.badServerResponse)))
            //                return
            //            }
            //
            //            guard let mimeType = httpResponse.mimeType, mimeType == "application/json",
            //                  let data = data else {
            //                completion(.failure(URLError(.cannotParseResponse)))
            //                return
            //            }
            //
            //            do {
            //                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            //                           let token = json["Token"] as? String {
            //
            //                            // Ici, nous décodons le token juste après l'avoir récupéré
            //                            if let payload = self.decodeJWT(token: token) {
            //                                print(payload)
            ////                                completion(.success(payload))
            //                            } else {
            //                                completion(.failure(URLError(.cannotDecodeContentData)))
            //                            }
            //
            //                        } else {
            //                            completion(.failure(URLError(.cannotParseResponse)))
            //                        }
            //                    } catch {
            //                        completion(.failure(error))
            //                    }
            //                }
            //
            //                task.resume()
            //            }
            //__________________________________CONFIG TOKEN SEND IN RESPONSE________________________________
            func removeBearerPrefix(from token: String) -> String {
                let bearerPrefix = "Bearer "
                if token.hasPrefix(bearerPrefix) {
                    return String(token.dropFirst(bearerPrefix.count))
                }
                return token
            }
            
            func decodeJWT(token: String) -> [String: Any]? {
                let segments = token.components(separatedBy: ".")
                guard segments.count == 3 else {
                    return nil
                }
                
                var base64String = segments[1]
                if base64String.count % 4 != 0 {
                    let padlen = 4 - base64String.count % 4
                    base64String += String(repeating: "=", count: padlen)
                }
                
                guard let data = Data(base64Encoded: base64String) else {
                    return nil
                }
                
                let payload = try? JSONSerialization.jsonObject(with: data, options: [])
                return payload as? [String: Any]
            }
            
            //        if let valeur = UserDefaults.standard.string(forKey: "tokenverificationcodesms") {
            
            //    __________________________
            
            
            
            
            
            
            
            
     
 
