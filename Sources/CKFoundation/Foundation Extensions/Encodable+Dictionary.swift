//
//  Encodable+Dictionary.swift
//  
//
//  Created by Dmitriy Zharov on 16.02.2021.
//

import Foundation

public extension Encodable {
    /// Преобразование кодируемого значения в словарь.
    /// - Returns: Словарь.
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            fatalError("Failed to encode data")
        }
        guard let dictionary = try? JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
        ) as? [String: Any] else {
            fatalError("Could not cast JSON content to Params")
        }
      
        return dictionary
    }
}
