//
//  AssociatedObject.swift
//  
//
//  Created by Dmitriy Zharov on 01.04.2021.
//

import Foundation

/**
 Обертка для objc_associatedObject.
 
 Позволяет добавить любые свойства к классам через `extension`. Это возможно благодаря возможностям ObjC Runtime.
 
 Пример использования:
 ```
 // Да, поддерживаются даже структуры!
 var rangeAssociatedObject = AssociatedObject<Range<Int>>()
 
 class A {}
 
 extension A {
    var range: Range<Int>? {
        get { rangeAssociatedObject[self] }
        set { rangeAssociatedObject[self] = newValue }
    }
 }
 ```
 
 - SeeAlso:
 [Associated Objects](https://nshipster.com/associated-objects/)
 */
public final class AssociatedObject<T: AnyObject> {
    private let policy: objc_AssociationPolicy

    /// - Parameter policy: An association policy that will be used when linking objects.
    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        self.policy = policy
    }

    /// Accesses associated object.
    /// - Parameter index: An object whose associated object is to be accessed.
    public subscript(index: AnyObject) -> T? {
        get { return objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as? T }
        set { objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, policy) }
    }
}
