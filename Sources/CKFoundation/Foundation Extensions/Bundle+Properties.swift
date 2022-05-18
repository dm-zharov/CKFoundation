//
//  Bundle+Properties.swift
//  
//
//  Created by Dmitriy Zharov on 11.02.2021.
//

import Foundation

public extension Bundle {
    /// Релизная версия бандла. Пример: `1.0`.
    var bundleVersion: String? {
        let infoDictionary = self.infoDictionary
        
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// Билд версия бандла. Пример: `42`.
    var buildVersion: String? {
        let infoDictionary = self.infoDictionary
        
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    /// Универсальный метод для поиска бандла с ресурсами при вызове из различных таргетов (например: из основного приложения, расширения, фреймворка, свифтмодуля и так далее).
    /// В зависимости от того, какой таргет вы собираете, бандл с ресурсами будет хранится в различных местах, что и создает трудности для поиска.
    /// - Parameters:
    ///   - bundleClass: Любой класс, содержащийся в искомом бандле.
    ///   - packageName: Идентификатор пакета, содержащего модуль. Пример: пакет `CoreKit`, с модулем `CKUI`.
    ///   - moduleName: Идентификат модуля. Например: `CKUI`.
    /// - Returns: Искомый бандл с ресурсами.
    static func resourceBundle(bundleClass: AnyClass,
                               packageName: String = "CoreKit",
                               moduleName: String) -> Bundle {
        let bundleName = "\(packageName)_\(moduleName)"
        let candidates = [
            // Bundle should be present here when the package is linked into an App
            Bundle.main.resourceURL,
            
            // Bundle should be present here when the package is linked into a framework
            Bundle(for: bundleClass.self).resourceURL,
            
            // For command-line tools
            Bundle.main.bundleURL,
            
            // Bundle should be present here when running tests for a framework
            Bundle(for: bundleClass.self).resourceURL?
                .deletingLastPathComponent(),
        ]
        
        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        
        fatalError("Unable to find a bundle in candidates: \(candidates)")
    }
}
