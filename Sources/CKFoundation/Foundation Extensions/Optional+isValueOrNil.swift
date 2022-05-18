//
//  Optional+NSNumber.swift
//  
//
//  Created by Dmitriy Zharov on 25.01.2021.
//

import Foundation

public extension Optional where Wrapped: NSNumber {
    /// Проверка на отсутствие значения.
    var isZeroOrNil: Bool {
        if let self = self {
            return self.intValue == 0
        }
        
        return true
    }
}

public extension Optional where Wrapped: StringProtocol {
    /// Проверка на отсутствие значения.
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
