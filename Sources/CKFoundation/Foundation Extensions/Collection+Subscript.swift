//
//  File.swift
//  
//
//  Created by Dmitriy Zharov on 25.01.2021.
//

import Foundation

public extension Collection {
    /**
     Безопасное получение значение из коллекции по индексу.
     
     Пример использования:
     ```
     let numbers = [1, 2, 3]
     if let firstNumber = numbers[safe: 0] {
        print(firstNumber)
     }
     ```
     */
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
