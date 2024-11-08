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
        
        public init() {}
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
        public var OSVersion: VersionType
        public var appVersion: VersionType
        
        public init(
            id: UUID,
            OSVersion: VersionType,
            appVersion: VersionType
        ) {
            self.id = id
            self.OSVersion = OSVersion
            self.appVersion = appVersion
        }
    }
}

