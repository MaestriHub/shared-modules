import Foundation

/// Namespace для всех DTOs относящихся к User
public enum User {
    public enum Parameters {}
    public enum Responses {}
}

public struct UserOption: OptionSet, Codable {

    public var rawValue: Int
    
    public static let customer = UserOption(rawValue: 1 << 0)
    public static let professional = UserOption(rawValue: 1 << 1)
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

//MARK: - Parameters -

public extension User.Parameters {
    
    struct CreateProfessional: Parametable {
        public var nickname: String
        public var avatar: String
        public var contact: Contact.Parameters.Create
    }
    
    struct CreateCustomer: Parametable {
        public var nickname: String
        public var avatar: String
        public var contact: [Contact.Parameters.Create]
    }
    
    struct Patch: Parametable {
        var nickname: String?
        var avatar: String?
    }
}

//MARK: - Responses -

public extension User.Responses {
    
    /// Возращает информацию о пользователе для отображения экрана профиля
    struct Full: Responsable, Identifiable {
        public var id: UUID?
        public var avatar: String?
        public var nickname: String?
        public var contact: Contact.Responses.Full
        public var options: UserOption
    }
}
