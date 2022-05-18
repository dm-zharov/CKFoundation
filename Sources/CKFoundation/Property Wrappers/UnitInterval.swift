//
//  UnitInterval.swift
//  
//
//  Created by Dmitriy Zharov on 22.12.2021.
//

import Foundation

/**
 Ограничение значения свойства интервалом 0...1.
 
 Пример использования:
 ```
 struct Image {
     @UnitInterval var scaleFactor: Double = 1.0
 }
 ```
 
 Попытка установить значение scaleFactor, выходящее за диапазон 0...1, приведёт к тому, что свойство примет значение, ближайшее к минимуму или максимуму интервала.
 */
@propertyWrapper
public struct UnitInterval<Value: FloatingPoint> {
    @Clamping(0...1) public var wrappedValue: Value = .zero

    public init(wrappedValue value: Value) {
        self.wrappedValue = value
    }
}
