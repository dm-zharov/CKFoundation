//
//  PreferenceSpecifier.swift
//  Docs
//
//  Created by Dmitriy Zharov on 05.10.2021.
//

import Foundation

/// Управляемый позвователем параметр из системного приложения "Настройки"
/// Settings Application Schema Reference:  https://apple.co/2ZZVlH6
public struct PreferenceSpecifier: RawRepresentable {
    public enum `Type`: String {
        case group = "PSGroupSpecifier"
        case childPane = "PSChildPaneSpecifier"
        case textField = "PSTextFieldSpecifier"
        case title = "PSTitleValueSpecifier"
        case toggleSwitch = "PSToggleSwitchSpecifier"
        case slider = "PSSliderSpecifier"
        case multivalue = "PSMultiValueSpecifier"
        case radioGroup = "PSRadioGroupSpecifier"
    }
    
    public var type: `Type` {
        guard let typeValue = rawValue["Type"] as? String else {
            fatalError("Preference specifier's type doesn't contain type")
        }
        return Type(rawValue: typeValue)!
    }
    
    public var title: String? {
        rawValue["Title"] as? String
    }
    
    public var key: String {
        guard ![.group, .childPane].contains(type) else {
            fatalError("Preference specifier's type doesn't contain key value")
        }
        return rawValue["Key"] as! String
    }
    
    public var defaultValue: Any {
        guard ![.group, .childPane].contains(type) else {
            fatalError("Preference specifier's type doesn't contain default value")
        }
        return rawValue["DefaultValue"]!
    }
    
    // MARK: - Lifecycle
    public let rawValue: Dictionary<String, Any>
    
    public init?(rawValue: Dictionary<String, Any>) {
        self.rawValue = rawValue
    }
}

// MARK: - Group
extension PreferenceSpecifier {
    public var footerText: String {
        guard type == .group else {
            fatalError("Preference specifier's type doesn't contain footer text value")
        }
        return rawValue["FooterText"] as! String
    }
}

// MARK: - ChildPane
extension PreferenceSpecifier {
    public var file: String {
        guard type == .childPane else {
            fatalError("Preference specifier's type doesn't contain file value")
        }
        return rawValue["File"] as! String
    }
}

// MARK: - Toggle Switch
extension PreferenceSpecifier {
    public var trueValue: Any {
        guard type == .toggleSwitch else {
            fatalError("Preference specifier's type doesn't contain key value")
        }
        return rawValue["trueValue"]!
    }
    
    public var falseValue: Any {
        guard type == .toggleSwitch else {
            fatalError("Preference specifier's type doesn't contain key value")
        }
        return rawValue["FalseValue"]!
    }
}

// MARK: - ...
