//
//  Sequence+Sorted.swift
//  Docs
//
//  Created by Dmitriy Zharov on 01.09.2021.
//

public extension Sequence {
    /// Сортировка последовательности по возврастанию на основе сравнений свойств объектов, определяемых по `KeyPath`.
    /// - Returns: Отсортированная по возврастанию последовательность.
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { lhs, rhs in
            return lhs[keyPath: keyPath] < rhs[keyPath: keyPath]
        }
    }
}
