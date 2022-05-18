//
//  Progress+Child.swift
//
//
//  Created by Dmitriy Zharov on 02.07.2021.
//
//

import Foundation

public extension Progress {
    /// Процент выполнения задачи.
    enum Percentage {
        /// Выполена часть задачи (в диапазоне от 0 до 100).
        case fraction(Int64)
        /// Задача полностью выполнена.
        case complete
    }
    
    /// Выстроение иерархии между Progress.
    /// - Parameters:
    ///   - child: Дочерний прогресс, пополняющий прогресс выполнения родителя.
    ///   - inPercentage: Заполняемый дочерним прогрессом процент прогресса родителя. Например: 1/2.
    /// - Throws: Данная ошибка выбрасывается при некорректной работе с API
    func addChild(_ child: Progress, withPendingPercentage inPercentage: Percentage) throws {
        guard child.hasParent == false else {
            return
        }
        
        let pendingUnitCount: Int64
        switch inPercentage {
        case .fraction(let unitCount) where unitCount > 0 && unitCount < 100:
            pendingUnitCount = unitCount

        case .complete:
            pendingUnitCount = 100

        default:
            fatalError("Percentage should be in range between 0 and 100")
        }
        
        addChild(child, withPendingUnitCount: pendingUnitCount)
        child.hasParent = true
    }
    
    convenience init(totalPercentage percentage: Percentage) {
        let totalUnitCount: Int64
        switch percentage {
        case .fraction(let unitCount):
            totalUnitCount = unitCount

        case .complete:
            totalUnitCount = 100
        }
        self.init(totalUnitCount: totalUnitCount)
    }
}

private extension Progress {
    var hasParent: Bool {
        get {
            userInfo[.hasParent] as? Bool ?? false
        }
        set {
            setUserInfoObject(newValue, forKey: .hasParent)
        }
    }
}

private extension ProgressUserInfoKey {
    static let hasParent = ProgressUserInfoKey(rawValue: "hasParent")
}
