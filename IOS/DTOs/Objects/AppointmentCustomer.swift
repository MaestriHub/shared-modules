import Foundation

/// Пространство имен `AppointmentCustomer` содержит типы данных для работы с записями на прием.
///
/// В него входят как параметры для запросов (`Parameters`), так и модели ответов (`Responses`),
/// которые используются для сериализации данных, отправляемых и получаемых от API.
public enum AppointmentCustomer {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension AppointmentCustomer.Parameters {
    
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
        public let type: AppointmentType
        public let time: SafeDateInterval
        
        public init(
            type: AppointmentType,
            time: SafeDateInterval
        ) {
            self.type = type
            self.time = time
        }
    }

    /// ???
    /// `Patch` определяет параметры для частичного обновления данных записи на прием.
    ///
    /// ### Properties:
    ///   - time: ``Interval?`` - новый временной интервал для записи, если требуется изменение.
    ///  - price: ``Price?`` - новая цена для записи, если требуется изменение.
    ///  - procedures: `[UUID]?` - новый список идентификаторов процедур, если требуется изменение.
    struct Patch: Parametable {
        public let time: SafeDateInterval
        
        public init(
            time: SafeDateInterval
        ) {
            self.time = time
        }
    }
}

//MARK: - Responses -

public extension AppointmentCustomer.Responses {
    
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
    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var status: AppointmentStatus
        public var salon: Salon.Responses.Partial
        public var procedures: [Procedure.Responses.Partial]
        public var time: SafeDateInterval
        public var price: Price
        public var address: Address
        
        public init(
            id: UUID,
            status: AppointmentStatus,
            salon: Salon.Responses.Partial,
            procedures: [Procedure.Responses.Partial],
            time: SafeDateInterval,
            price: Price,
            address: Address
        ) {
            self.id = id
            self.status = status
            self.salon = salon
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
    struct Partial: Responsable, Identifiable, Equatable {
        public var id: UUID
        public var status: AppointmentStatus
        public var time: SafeDateInterval
        public var price: Price
        public var procedures: [Procedure.Responses.Partial]
        
        public init(
            id: UUID,
            status: AppointmentStatus,
            time: SafeDateInterval,
            price: Price,
            procedures: [Procedure.Responses.Partial]
        ) {
            self.id = id
            self.status = status
            self.time = time
            self.price = price
            self.procedures = procedures
        }
    }
}

