//
//  DIContainer.swift
//  WhatIAmToDo
//
//  Created by Юлия Гудошникова on 22.02.2025.
//

class DIContainer {

    static let shared = DIContainer()

    private var services: [String: Any] = [:]

    init() {}

    func resolve<T>() -> T {
        let id = String(describing: T.self)

        if let service = services[id] as? T {
            return service
        } else {
            fatalError("No registered service for ")
        }
    }

    func register<T>(_ service: T) {
        let id = String(describing: T.self)
        services[id] = service
    }

}
