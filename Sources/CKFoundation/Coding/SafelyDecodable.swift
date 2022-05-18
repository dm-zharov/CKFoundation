//
//  SafelyDecodable.swift
//  Docs
//
//  Created by Dmitriy Zharov on 24.08.2021.
//

import Foundation

/**
 Безопасное декодирование данных.
 
 При декодировании данных иногда может встретиться неизвестное значение перечисления, что приведет к выбросу исключения.
 
 Стандартный способ решения проблемы:
 ```
  struct Data: Decodable {
      let type: Type? // Optional
  }
 ```

 Однако данный способ не позволяет различить между собой получение неизвестного ранее значения и его полное отсутствие.

 Данный протокол помогает обработать такой кейс и выставить некоторое значение по умолчанию (чаще всего `unknown`) , что упрощает работу с моделями данных.
 
 Пример реализации модели, соответствующей протоколу `SafelyDecodable`:
    ```
    enum DataType: String, SafelyDecodable {
        case first = "FIRST"
        case second = "SECOND"
        case unknown = UUID().uuidString // Любая строка
 
        // Значение по умолчанию при неудачном декодировании
        public static let defaultDecoderValue: Self = .unknown
    }
 
    struct Data: Decodable {
        // Если от сервера придет неизвестный нам "THIRD",
        // свойство будет равным `.unknown`.
        // Если от сервера поступит `nil`,
        // свойство будет равным `nil`.
        let type: DataType?
    }
    ```
 
 - Author: Дмитрий Жаров
 */
public protocol SafelyDecodable: RawRepresentable, Decodable {
    /// Значение, которое будет использовано при встрече `nil`.
    static var defaultDecoderValue: Self { get }
}

/// Дефолтная реализация протокола SafelyDecodable.
public extension SafelyDecodable where RawValue: Decodable {
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(RawValue.self)
        self = Self(rawValue: value) ?? Self.defaultDecoderValue
    }
}
