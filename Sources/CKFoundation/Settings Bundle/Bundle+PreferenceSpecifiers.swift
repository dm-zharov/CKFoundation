//
//  Bundle+Settings.swift
//  Docs
//
//  Created by Dmitriy Zharov on 05.10.2021.
//

import Foundation

public extension Bundle {
    /// Главные настройки приложения из `Settings.bundle`
    var rootPreferenceSpecifiers: [PreferenceSpecifier]? {
        preferenceSpecifiers(forPlistName: "Root")
    }
    
    /// Дополнительные разделы настроек приложения из `Settings.bundle`
    func preferenceSpecifiers(forPlistName plistName: String) -> [PreferenceSpecifier]? {
        guard let settingsBundleURL = url(
            forResource: "Settings",
            withExtension: "bundle"
        ) else {
            return nil
        }
        
        let rootPlistURL = settingsBundleURL.appendingPathComponent(plistName).appendingPathExtension("plist")
        guard let rootDictionary = NSDictionary(contentsOfFile: rootPlistURL.path) else {
            return nil
        }
        
        guard let preferenceSpecifiers = rootDictionary["PreferenceSpecifiers"] as? [Dictionary<String, Any>] else {
            return nil
        }
        
        return preferenceSpecifiers.compactMap { PreferenceSpecifier(rawValue: $0) }
    }
    
    /// Поиск необходимой настройки по уникальному идентификатору
    /// - Parameter key: Уникальный идентификатор настройки
    /// - Returns: Настройка
    func preferenceSpecifier(forKey key: String) -> PreferenceSpecifier? {
        guard let rootPreferenceSpecifiers = rootPreferenceSpecifiers else {
            return nil
        }
        
        let wholePreferenceSpecifiers = rootPreferenceSpecifiers.flatMap { preferenceSpecifier -> [PreferenceSpecifier] in
            guard preferenceSpecifier.type == .childPane else {
                return [preferenceSpecifier]
            }
            return self.preferenceSpecifiers(forPlistName: preferenceSpecifier.file) ?? []
        }
        
        return wholePreferenceSpecifiers.first(where: { $0.key == key })
    }
}
