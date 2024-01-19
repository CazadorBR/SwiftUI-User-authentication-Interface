//
//  AuthService.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-08.
//

import Foundation

class AuthService {
    private let session: URLSession
    let baseURL = "http://192.168.1.116:3000/"

//    let url  = URL(string: baseURL + "EditImageProfile")
    init() {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 30 // seconds
            configuration.timeoutIntervalForResource = 60 // seconds
            self.session = URLSession(configuration: configuration)
        }

    
    
    
    func signUp(email: String, password: String,name:String ,completion: @escaping (Bool, Error?) -> Void) {
        let url  = URL(string: baseURL + "signupU")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password,
            "name": name,
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error)
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                completion(true, nil)
            } else {
                completion(false, nil)
            }
        }
        task.resume()
    }
    func signInadmin(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url  = URL(string: baseURL + "SignIn")else {
//        guard let url = URL(string: "http://192.168.1.126:3000/SignIn") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let parameters: [String: Any] = [
            "email": email,
            "password": password,
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let mimeType = httpResponse.mimeType, mimeType == "application/json",
                  let data = data else {
                completion(.failure(URLError(.cannotParseResponse)))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let token = json["Token"] as? String {  // Make sure this key matches what your API sends
                    UserDefaults.standard.set(token, forKey: "tokenAuth")
                    completion(.success(token))
                } else {
                    completion(.failure(URLError(.cannotParseResponse)))
                }
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }

    
    func signIn(email: String, password: String,completion: @escaping (Bool, Error?) -> Void) {

        let url  = URL(string: baseURL + "SignIn")!

//        let url = URL(string: "http://192.168.1.126:3000/SignIn")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let parameters: [String: Any] = [
            "email": email,
            "password": password,
         ]
        // Convert parameters to JSON data.
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error)
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print(httpResponse.statusCode)
                print(httpResponse.self)
                completion(true, nil)

            } else {
                completion(false, nil)
            }
        }


        task.resume()
    }



}

