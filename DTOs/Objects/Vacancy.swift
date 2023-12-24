import Foundation

/// Пространство имен `Vacancy` содержит типы данных для работы с записями на прием.
///
/// В него входят как параметры для запросов (`Parameters`), так и модели ответов (`Responses`),
/// которые используются для сериализации данных, отправляемых и получаемых от API.
public enum Vacancy {
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Vacancy.Parameters {
    
    /// Параметры `Invite` используются для отправки приглашения сотрудникам присоединиться к сервису.
    /// Доступ к этому функционалу предоставляется как профессиональным пользователям (Pro), так и обычным пользователям.
    ///
    /// ### Properties:
    /// - name: `String` - имя сотрудника, которое будет использоваться в приглашении.
    /// - salonId: `UUID` - идентификатор салона для связи нового сотрудника и салона
    struct Invite: Responsable {
        public let name: String
        public let salonId: UUID
        
        public init(
            name: String,
            salonId: UUID
        ) {
            self.name = name
            self.salonId = salonId
        }
    }
}

// MARK: - Responses -

public extension Vacancy.Responses {
    
    /// Полные данные об адресе для ответа.
    /// Структура включает в себя идентификатор и основные данные о вакансии, используемые для ответа в API.
    ///
    /// ### Properties:
    ///   - id: Уникальный идентификатор адреса.
    ///  - url: Ссылка которая отправляет сотруднику
    struct Partial: Responsable, Identifiable, Equatable {
        public var id: UUID
        public var url: URL
        
        public init(
            id: UUID,
            url: URL
        ) {
            self.id = id
            self.url = url
        }
    }
    
    struct Full: Responsable, Identifiable, Equatable {
        public var id: UUID
        public var description: String
        public var salon: Salon.Responses.Partial
        public var candidates: [Employee.Responses.Partial]
        public var url: URL?
        
        public init(
            id: UUID,
            description: String,
            salon: Salon.Responses.Partial,
            candidates: [Employee.Responses.Partial],
            url: URL? = nil
        ) {
            self.id = id
            self.description = description
            self.salon = salon
            self.candidates = candidates
            self.url = url
        }
    }
}

