//
//  Clamping.swift
//
//
//  Created by Dmitriy Zharov on 22.10.2020.
//
//

import Foundation

/**
 Определение диапазона для значения.
 
 Пример использования:
 ```
 struct Solution {
     @Clamping(0...14) var pH: Double = 7.0
 }
 ```
 
 Попытка установить значение pH, выходящее за диапазон от (0...14), приведёт к тому, что свойство примет значение, ближайшее к минимуму или максимуму интервала.
 */
@propertyWrapper
public struct Clamping<Value: Comparable> {
    private let range: ClosedRange<Value>
    private var value: Value

    public init(wrappedValue value: Value, _ range: ClosedRange<Value>) {
        precondition(range.contains(value))
        self.value = value
        self.range = range
    }

    public var wrappedValue: Value {
        get { value }
        set { value = min(max(range.lowerBound, newValue), range.upperBound) }
    }
}
