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
    ///   - startDate: `Date?` - начало временного интервала для выборки данных.
    ///  - endDate: `Date?` - конец временного интервала для выборки данных.
    ///  - employees: `[UUID]?` - необязательный массив идентификаторов сотрудников для фильтрации.
    ///  - salons: `[UUID]?` - необязательный массив идентификаторов салонов для фильтрации.
    /// Если массив не предоставлен, выборка осуществляется по всем сущностям.
    struct Retrieve: Parametable {
        
        public let startDate: Date?
        public let endDate: Date?
        public let employees: [UUID]?
        public let salons: [UUID]?
        
        public init(
            startDate: Date?,
            endDate: Date?,
            employees: [UUID]? = nil,
            salons: [UUID]? = nil
        ) {
            self.startDate = startDate
            self.endDate = endDate
            self.employees = employees
            self.salons = salons
        }
    }
    
    /// `Create` описывает параметры тела запроса для создания новой записи на прием.
    ///
    /// ### Properties:
    ///   - salon: `UUID` - идентификатор салона.
    ///  - master: `UUID` - идентификатор мастера. Если нету то значит Appointment открыт к подтверждению любым клиентом у которого будет доступ к ссылке
    ///  - customer: `UUID?` - идентификатор клиента.
    ///  - procedures: `[UUID]` - массив идентификаторов процедур.
    ///  - time: `Interval` - временной интервал записи на прием.
    ///  - price: `Price` - цена записи на прием.
    ///  - address: `UUID` - идентификатор адреса салона.
    struct Create: Parametable {
        public let salon: UUID
        public let master: UUID
        public let customer: UUID?
        public let procedures: [UUID]
        public let time: Interval
        public let price: Price
        public let address: UUID
        
        public init(
            salon: UUID,
            master: UUID,
            customer: UUID?,
            procedures: [UUID],
            time: Interval,
            price: Price,
            address: UUID
        ) {
            self.salon = salon
            self.master = master
            self.customer = customer
            self.procedures = procedures
            self.time = time
            self.price = price
            self.address = address
        }
    }

    /// `Patch` определяет параметры для частичного обновления данных записи на прием.
    ///
    /// ### Properties:
    ///   - time: ``Interval?`` - новый временной интервал для записи, если требуется изменение.
    ///  - price: ``Price?`` - новая цена для записи, если требуется изменение.
    ///  - procedures: `[UUID]?` - новый список идентификаторов процедур, если требуется изменение.
    struct Patch: Parametable {
        public let time: Interval?
        public let price: Price?
        public let procedures: [UUID]?
        
        public init(
            time: Interval? = nil,
            price: Price? = nil,
            procedures: [UUID]? = nil
        ) {
            self.time = time
            self.price = price
            self.procedures = procedures
        }
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
    ///  - customerLink: ``URL`` - ссылка на назначения клиента.
    ///  - master: ``Employee.Responses.Partial`` - информация о мастере.
    ///  - procedures: ``[Procedure.Responses.Partial]`` - список процедур.
    ///  - time: ``Interval`` - временной интервал записи.
    ///  - price: ``Price`` - цена записи.
    ///  - address: ``Address.Responses.Full`` - полная информация об адресе салона.
    struct Full: Responsable, Identifiable {
        public var id: UUID
        public var salon: Salon.Responses.Partial
        //TODO: Vitalik возможно стоит customer и customerLink объеденить в одно поля используя Enum например, но это не точно
        public var customer: Customer.Responses.Partial?
        public var customerLink: URL?
        public var master: Employee.Responses.Partial
        public var procedures: [Procedure.Responses.Partial]
        public var time: Interval
        public var price: Price
        public var address: Address.Responses.Full
        
        public init(
            id: UUID,
            salon: Salon.Responses.Partial,
            customer: Customer.Responses.Partial?,
            customerLink: URL?,
            master: Employee.Responses.Partial,
            procedures: [Procedure.Responses.Partial],
            time: Interval,
            price: Price,
            address: Address.Responses.Full
        ) {
            self.id = id
            self.salon = salon
            self.customer = customer
            self.master = master
            self.procedures = procedures
            self.time = time
            self.price = price
            self.address = address
        }
    }
    
    /// `Partial` содержит частичную информацию о записи на прием, обычно используемую для списков и обзоров.
    ///
    /// ### Properties:
    ///   - id: `UUID` - уникальный идентификатор записи.
    ///  - customer: ``Customer.Responses.Partial`` - информация о клиенте.
    ///  - master: ``Employee.Responses.Partial`` - информация о мастере.
    ///  - time: ``Interval`` - временной интервал записи.
    ///  - price: ``Price`` - цена записи.
    struct Partial: Responsable, Identifiable {
        public var id: UUID
        public var customer: Customer.Responses.Partial?
        public var customerLink: URL?
        public var master: Employee.Responses.Partial
        public var time: Interval
        public var price: Price
        
        public init(
            id: UUID,
            customer: Customer.Responses.Partial?,
            customerLink: URL?,
            master: Employee.Responses.Partial,
            time: Interval,
            price: Price
        ) {
            self.id = id
            self.customer = customer
            self.master = master
            self.time = time
            self.price = price
        }
    }
}
