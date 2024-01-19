//
//  Data.swift
//  EcoGuide-Swift
//
//  Created by ben romdhane fedi on 2023-11-21.
//

import Foundation
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
