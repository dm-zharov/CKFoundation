//
//  UserDefaults+PreferenceSpecifier.swift
//  Docs
//
//  Created by Dmitriy Zharov on 05.10.2021.
//

import Foundation

public extension UserDefaults {
    /// Запись дефолтных параметров из `Settings.bundle` в `UserDefaults`
    /// - Parameter resetOnUpdate: Перезаписать ли имеющиеся значения в `UserDefaults` при повышении версии приложения?
    class func registerStandardUserDefaultsFromSettingsBundle(resetOnUpdate: Bool = true) {
        let bundle = Bundle.main
        let userDefaults = UserDefaults.standard
        
        guard
            let rootPreferenceSpecifiers = bundle.rootPreferenceSpecifiers,
            let bundleVersion = bundle.bundleVersion
        else {
            return
        }
        
        // При обновлении приложения необходимо перезаписать дефолтные значения настроек
        let resetRegisteredSettings = resetOnUpdate && userDefaults.string(forKey: "storedBundleVersion") != bundleVersion
        
        /// Запись дефолтного значения параметра в текущий `UserDefaults` при его отсутствии либо при обновлении
        func set(preferenceSpecifiers: [PreferenceSpecifier]) {
            preferenceSpecifiers.forEach { preferenceSpecifier in
                switch preferenceSpecifier.type {
                case .toggleSwitch, .slider, .title, .textField, .multivalue, .radioGroup:
                    guard userDefaults.value(forKey: preferenceSpecifier.key) == nil || resetRegisteredSettings else {
                        break
                    }
                    userDefaults.setValue(preferenceSpecifier.defaultValue, forKey: preferenceSpecifier.key)
                    
                case .group:
                    break
                    
                case .childPane:
                    if let childPreferenceSpecifiers = bundle.preferenceSpecifiers(forPlistName: preferenceSpecifier.file) {
                        set(preferenceSpecifiers: childPreferenceSpecifiers)
                    }
                }
            }
        }
        
        set(preferenceSpecifiers: rootPreferenceSpecifiers)
        
        // Сохраняем текущую версию приложения для будущих проверок
        userDefaults.set(bundleVersion, forKey: "storedBundleVersion")
    }
}
