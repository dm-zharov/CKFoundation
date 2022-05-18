//
//  UserDefault.swift
//  
//
//  Created by Dmitriy Zharov on 16.11.2021.
//

import Foundation

/**
 Запись/чтение значения выполняется в/из UserDefaults.
 
 Пример использования:
 ```
 struct Settings {
    @UserDefault(key: "mark-as-read")
    var autoMarkMessagesAsRead = true // Значение по умолчанию
 
    @UserDefault(key: "signature")
     var messageSignature: String?
 }
 ```
 */
@propertyWrapper
public struct UserDefault<Value> {
    private let key: String
    private let defaultValue: Value
    private let storage: UserDefaults

    public init(wrappedValue defaultValue: Value,
                key: String,
                storage: UserDefaults = .standard) {
        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
    
    public var wrappedValue: Value {
        get { storage.value(forKey: key) as? Value ?? defaultValue }
        set { storage.setValue(newValue, forKey: key) }
    }

}

extension UserDefault where Value: ExpressibleByNilLiteral {
    public init(key: String, storage: UserDefaults = .standard) {
        self.init(wrappedValue: nil, key: key, storage: storage)
    }
}
