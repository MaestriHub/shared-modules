import Foundation

/// Пространство имен `Professional` содержит типы данных для работы с информацией о клиентах.
///
/// В него входят параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обмена данными между клиентом и сервером в контексте клиентских данных.
public enum Professional {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Professional.Parameters {
    
    struct Create: Parametable {
        
        public init() {}
    }
}

//MARK: - Responses -

public extension Professional.Responses {
    
    struct Partial: Responsable, Equatable {
        
        public var user: User.Responses.Partial
        
        public init(
            user: User.Responses.Partial
        ) {
            self.user = user
        }
    }
}
