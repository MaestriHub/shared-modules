//
//  Device.swift
//  Created by Vitalii Shevtsov on 3/22/24.
//

import Foundation

/// Пространство имен `Device` содержит типы данных для работы с информацией о клиентах.
///
/// В него входят  модели ответов (`Responses`),
/// используемые для обмена данными между клиентом и сервером в контексте клиентских данных.
public enum Device {
    public enum Parameters {}
    public enum Responses {}
}

public extension Device.Parameters {

    struct Create: Parametable {
        public var manufacturer : String?
        public var model: String?
        public var system: SystemType?
        public var appVersion: String?
        public var country: String?
        public init(
            manufacturer: String? = nil,
            model: String? = nil,
            system: SystemType? = nil,
            appVersion: String? = nil,
            country: String? = nil
        ) {
            self.manufacturer = manufacturer
            self.model = model
            self.system = system
            self.appVersion = appVersion
            self.country = country
        }
    }
    
    struct RegisterPush: Parametable {
        public enum Token: Codable {
            case apple(token: String)
            case fcm(token: String)
        }
        
        public let token: Token
        
        public init(token: Token) {
            self.token = token
        }
    }
}

// MARK: - Responses -

public extension Device.Responses {
    
    struct Full: Responsable, Identifiable, Equatable {
        public var id: UUID
        public var version: VersionType?
        
        public init(
            id: UUID,
            version: VersionType? = nil
        ) {
            self.id = id
            self.version = version
        }
    }
}

