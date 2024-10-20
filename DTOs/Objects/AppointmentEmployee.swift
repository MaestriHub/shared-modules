import Foundation

/// Пространство имен `AppointmentEmployee` содержит типы данных для работы с записями на прием.
///
/// В него входят как параметры для запросов (`Parameters`), так и модели ответов (`Responses`),
/// которые используются для сериализации данных, отправляемых и получаемых от API.
public enum AppointmentEmployee {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension AppointmentEmployee.Parameters {
    
    
    // ???
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
        public let customer: UUID?
        
        public init(
            startDate: Date?,
            endDate: Date?,
            employees: [UUID]? = nil,
            salons: [UUID]? = nil,
            customer: UUID? = nil
        ) {
            self.startDate = startDate
            self.endDate = endDate
            self.employees = employees
            self.salons = salons
            self.customer = customer
        }
    }
    
    /// `Create` описывает параметры тела запроса для создания новой записи на прием.
    ///
    /// ### Properties:
    ///  - customer: `UUID?` - идентификатор клиента.
    ///  - procedure: `[UUID]` - массив идентификаторов процедур.
    ///  - time: `Interval` - временной интервал записи на прием.
    struct Create: Parametable {
        public let customerId: UUID
        public let type: AppointmentType
        public let time: DateInterval
        
        public init(
            customerId: UUID,
            type: AppointmentType,
            time: DateInterval
        ) {
            self.customerId = customerId
            self.type = type
            self.time = time
        }
    }
    
    struct Approve: Parametable {
        public let appointmentsEmployeeId: [UUID]
        
        public init (
            ids: [UUID]
        ) {
            self.appointmentsEmployeeId = ids
        }
    }

    /// `Patch` определяет параметры для частичного обновления данных записи на прием.
    ///
    /// ### Properties:
    ///   - time: ``Interval?`` - новый временной интервал для записи, если требуется изменение.
    ///  - price: ``Price?`` - новая цена для записи, если требуется изменение.
    ///  - procedures: `[UUID]?` - новый список идентификаторов процедур, если требуется изменение.
    struct Patch: Parametable {
        public let time: DateInterval
        
        public init(
            time: DateInterval
        ) {
            self.time = time
        }
    }
}

//MARK: - Responses -

public extension AppointmentEmployee.Responses {
    
    /// `Full` представляет полную информацию о записи на прием, включая все связанные данные.
    ///
    /// ### Properties:
    ///   - id: `UUID` - уникальный идентификатор записи на прием.
    ///  - salon: ``Salon.Responses.Partial`` - информация о салоне.
    ///  - customer: ``Customer.Responses.Partial`` - информация о клиенте.
    ///  - customerLink: ``URL`` - ссылка на назначения клиента.
    ///  - service: ``Service.Responses.Micro`` - информация о сервисе
    ///  - time: ``Interval`` - временной интервал записи.
    ///  - price: ``Price`` - цена записи.
    ///  - address: ``Address.Responses.Full`` - полная информация об адресе салона.
    struct Full: Responsable, Equatable {
        public var salon: Salon.Responses.Partial
        public var customer: Customer.Responses.Partial
        public var address: Address
        public var associative: [Base]
        
        public init(
            salon: Salon.Responses.Partial,
            customer: Customer.Responses.Partial,
            address: Address,
            associative: [Base]
        ) {
            self.salon = salon
            self.customer = customer
            self.address = address
            self.associative = associative
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
    struct Partial: Responsable, Equatable {
        public var customer: Customer.Responses.Partial
        public var associative: [Base]
        
        public init(
            customer: Customer.Responses.Partial,
            associative: [Base]
        ) {
            self.customer = customer
            self.associative = associative
        }
    }
    
    struct Base: Responsable, Identifiable, Equatable {
        public var id: UUID
        public var status: AppointmentStatus
        public var procedure: Procedure.Responses.Partial
        public var time: DateInterval
        public var price: Price
        
        public init(
            id: UUID,
            status: AppointmentStatus,
            procedure: Procedure.Responses.Partial,
            time: DateInterval,
            price: Price
        ) {
            self.id = id
            self.status = status
            self.procedure = procedure
            self.time = time
            self.price = price
        }
    }
}

