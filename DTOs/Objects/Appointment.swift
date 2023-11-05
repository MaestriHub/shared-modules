import Foundation

/// Пространство имен `Appointment` содержит типы данных для работы с записями на прием.
///
/// В него входят как параметры для запросов (`Parameters`), так и модели ответов (`Responses`),
/// которые используются для сериализации данных, отправляемых и получаемых от API.
public enum Appointment {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Appointment.Parameters {
    
    /// Параметры запроса `Retrieve` определяют фильтры для получения записей на прием
    /// за определенный временной интервал с возможной фильтрацией по сотрудникам и салонам.
    ///
    /// ### Properties:
    ///   - startDate: `Date` - начало временного интервала для выборки данных.
    ///  - endDate: `Date` - конец временного интервала для выборки данных.
    ///  - employees: `[UUID]?` - необязательный массив идентификаторов сотрудников для фильтрации.
    ///  - salons: `[UUID]?` - необязательный массив идентификаторов салонов для фильтрации.
    /// Если массив не предоставлен, выборка осуществляется по всем сущностям.
    struct Retrieve: Parametable {
        public var startDate: Date
        public var endDate: Date
        public var employees: [UUID]?
        public var salons: [UUID]?
    }
    
    /// `Create` описывает параметры тела запроса для создания новой записи на прием.
    ///
    /// ### Properties:
    ///   - salon: `UUID` - идентификатор салона.
    ///  - master: `UUID` - идентификатор мастера.
    ///  - customer: `UUID` - идентификатор клиента.
    ///  - procedures: `[UUID]` - массив идентификаторов процедур.
    ///  - time: `Interval` - временной интервал записи на прием.
    ///  - price: `Price` - цена записи на прием.
    ///  - address: `UUID` - идентификатор адреса салона.
    struct Create: Parametable {
        public var salon: UUID
        public var master: UUID
        public var customer: UUID
        public var procedures: [UUID]
        public var time: Interval
        public var price: Price
        public var address: UUID
    }

    /// `Patch` определяет параметры для частичного обновления данных записи на прием.
    ///
    /// ### Properties:
    ///   - time: `Interval?` - новый временной интервал для записи, если требуется изменение.
    ///  - price: `Price?` - новая цена для записи, если требуется изменение.
    ///  - procedures: `[UUID]?` - новый список идентификаторов процедур, если требуется изменение.
    struct Patch: Parametable {
        var time: Interval?
        var price: Price?
        var procedures: [UUID]?
    }
}

//MARK: - Responses -

public extension Appointment.Responses {
    
    /// `Full` представляет полную информацию о записи на прием, включая все связанные данные.
    ///
    /// ### Properties:
    ///   - id: `UUID` - уникальный идентификатор записи на прием.
    ///  - salon: ``Salon.Responses.Partial`` - информация о салоне.
    ///  - customer: ``Customer.Responses.Partial`` - информация о клиенте.
    ///  - master: ``Employee.Responses.Partial`` - информация о мастере.
    ///  - procedures: ``[Procedure.Responses.Partial]`` - список процедур.
    ///  - time: ``Interval`` - временной интервал записи.
    ///  - price: ``Price`` - цена записи.
    ///  - address: ``Address.Responses.Full`` - полная информация об адресе салона.
    struct Full: Responsable, Identifiable {
        public var id: UUID
        public var salon: Salon.Responses.Partial
        public var customer: Customer.Responses.Partial
        public var master: Employee.Responses.Partial
        public var procedures: [Procedure.Responses.Partial]
        public var time: Interval
        public var price: Price
        public var address: Address.Responses.Full
    }
    
    /// `Partial` содержит частичную информацию о записи на прием, обычно используемую для списков и обзоров.
    ///
    /// ### Properties:
    ///   - id: `UUID` - уникальный идентификатор записи.
    ///  - customer: `Customer.Responses.Partial` - информация о клиенте.
    ///  - master: `Employee.Responses.Partial` - информация о мастере.
    ///  - time: `Interval` - временной интервал записи.
    ///  - price: `Price` - цена записи.
    struct Partial: Responsable, Identifiable {
        public var id: UUID
        public var customer: Customer.Responses.Partial
        public var master: Employee.Responses.Partial
        public var time: Interval
        public var price: Price
    }
}
