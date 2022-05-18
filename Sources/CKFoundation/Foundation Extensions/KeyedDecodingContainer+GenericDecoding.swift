//
//  KeyedDecodingContainer+GenericDecoding.swift
//  
//
//  Created by Dmitriy Zharov on 23.04.2021.
//

import Foundation

extension KeyedDecodingContainer {
    /// Декодирование  значения по ключу.
    public func decode<T: Decodable>(forKey key: KeyedDecodingContainer<K>.Key) throws -> T {
        return try decode(T.self, forKey: key)
    }
    
    /// Декодирование опционального значения по ключу.
    public func decodeIfPresent<T: Decodable>(forKey key: KeyedDecodingContainer<K>.Key) throws -> T? {
        return try decodeIfPresent(T.self, forKey: key)
    }
}
