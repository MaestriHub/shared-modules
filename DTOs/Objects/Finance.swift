import Foundation

/// Пространство имен `Appointment` содержит типы данных для работы с записями на прием.
///
/// В него входят как параметры для запросов (`Parameters`), так и модели ответов (`Responses`),
/// которые используются для сериализации данных, отправляемых и получаемых от API.
public enum Operation {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Operation.Parameters {
    struct Create: Parametable {
        public var price: Price
        public var info: [String : String]
    }

    struct Patch: Parametable {
        public var price: Price?
        public var info: [String : String]?
    }
}


//MARK: - Responses -

public extension Operation.Responses {
    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
    }
}