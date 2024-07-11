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
        public var saveBoxId: UUID

        public init(
            price: Price,
            info: [String : String],
            saveBoxId: UUID
        ){
            self.price = price
            self.info = info
            self.saveBoxId = saveBoxId
        }
    }

    struct Patch: Parametable {
        public var price: Price?
        public var info: [String : String]?

        public init(
            price: Price? = nil,
            info: [String : String]? = nil
        ){
            self.price = price
            self.info = info
        }
    }
}


//MARK: - Responses -

public extension Operation.Responses {

    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID

        public init(
            id: UUID
        ){
            self.id = id
        }
    }
}