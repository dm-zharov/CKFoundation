//
//  Bounded.swift
//
//
//  Created by Dmitriy Zharov on 18.12.2020.
//
//

import Foundation

/**
 Фиксирование максимально допустимого размера коллекции.
 
 Пример использования:
 ```
 struct Data {
     @Bounded(100) var array: Array = [1, 2, 3]
 }
 ```
 
 Попытка добавить в коллекцию больше максимального количества элементов не приведет к его изменению.
 */
@propertyWrapper
public struct Bounded<Value: Collection> {
    private let boundary: UInt
    private var value: Value
    
    public var remainsCount: Int {
        Int(boundary) - value.count
    }
    
    public var isFull: Bool {
        remainsCount == 0
    }

    public init(wrappedValue value: Value, _ boundary: UInt) {
        self.value = value
        self.boundary = boundary
    }
    
    public var wrappedValue: Value {
        get { value }
        set {
            guard newValue.count <= boundary else {
                return
            }
            value = newValue
        }
    }
}

// MARK: - Equatable
extension Bounded: Equatable where Value: Equatable {}

// MARK: - Collection
extension Bounded: Collection {
    public typealias Index = Value.Index
    public typealias Element = Value.Element
    public typealias Iterator = Value.Iterator

    public var startIndex: Index { value.startIndex }
    public var endIndex: Index { value.endIndex }

    public func index(after index: Index) -> Index {
        return value.index(after: index)
    }
    
    __consuming public func makeIterator() -> Iterator {
        return value.makeIterator()
    }
    
    public subscript(index: Index) -> Iterator.Element {
        return value[index]
    }
}
