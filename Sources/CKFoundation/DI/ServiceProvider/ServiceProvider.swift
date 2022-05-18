//
//  ServiceProvider.swift
//  
//
//  Created by Dmitriy Zharov on 25.01.2021.
//

import Foundation

/**
 Простой сервис-локатор, удерживающий и предоставляющий требуемые сервисы. Идентификация сервисов реализована по типу.
 
 - Attention: Отсутствует возможность хранения нескольких инстансов одного и того же сервиса. Есть ли у вас такая потребность? Если есть, можно регистрировать сервис не по протоколу, а по конкретному типу.
 */
public protocol ServiceProviderProtocol {
    func resolve<T>() -> T?
    func dropServices()
}

public final class ServiceProvider: NSObject, ServiceProviderProtocol {
    // MARK: - Properties
    public static let shared = ServiceProvider()
    
    // MARK: - Private Properties
    private var services: [String: Any] = [:]

    // MARK: - Methods
    
    /// Регистрация сервиса в провайдере.
    public func register<T>(_ service: T) {
        let name = typeName(T.self)
        services[name] = service
        print("🧩 \(name) has been registered in ServiceProvider!")
    }

    // MARK: - Private
    
    /// Получение типа сервиса.
    /// - Parameter object: Сервис.
    /// - Returns: Тип сервиса в строковом представлении.
    private func typeName(_ object: Any) -> String {
        return "\(type(of: object))"
    }
}

public extension ServiceProvider {
    func resolve<T>() -> T? {
        let key = typeName(T.self)
        return services[key] as? T
    }
    
    func dropServices() {
        services = [:]
    }
}
