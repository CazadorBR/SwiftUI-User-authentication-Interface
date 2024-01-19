//
//  Authenticate_Service.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-08.
//

import Foundation
class Authenticate_Service {
    
    func signUpAdmin(email: String, password: String,name:String ,completion: @escaping (Bool, Error?) -> Void) {
        let url = URL(string: "http://192.168.1.129:3000/signupA")!
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
}
