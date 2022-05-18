//
//  ISO8601.swift
//  
//
//  Created by Dmitriy Zharov on 02.04.2021.
//

import Foundation
import UniformTypeIdentifiers

/**
 Проперти враппер для декодирования даты из строки.
 
    Пример использования:
    ```
    @ISO8601<ZonedDateTime> public var createdAt: Date?
    ```
 */
@propertyWrapper
public struct ISO8601<Format: ISO8601Format>: Equatable {
    public var wrappedValue: Date?
    
    public init(wrappedValue: Date?) {
        self.wrappedValue = wrappedValue
    }
}

extension ISO8601: Decodable {
    public init(from decoder: Decoder) throws {
        let dateFormatter = ISO8601DateFormatter.shared
        if let value = try? String(from: decoder) {
            // Important: Resetting this property can incur a significant performance cost, as it may cause internal state to be regenerated.
            if dateFormatter.formatOptions != Format.options {
                dateFormatter.formatOptions = Format.options
            }
            
            guard let date = dateFormatter.date(from: value) else {
                throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid Date Format"))
            }
            self.wrappedValue = date
        } else {
            self.wrappedValue = nil
        }
    }
}

private extension ISO8601DateFormatter {
    static let shared = ISO8601DateFormatter()
}
