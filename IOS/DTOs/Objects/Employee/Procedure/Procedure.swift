import Foundation
import MemberwiseInit

public enum Procedure {
    public enum Helpers {}
    
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Procedure.Parameters {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct All: Parametable {
        public let salonsFilter: [UUID]?
        public let employeesFilter: [UUID]?
        public let pagination: Pagination?
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Create: Parametable {
        public let duration: Minutes
        public let price: Price
        public let description: String?
        public let alias: String?
        public let parameters: [Procedure.Helpers.CreateParameterRequest]
        public let serviceId: UUID
        public let employeeIds: [UUID]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Update: Parametable {
        public let price: Price?
        public let duration: Minutes?
        public let description: UpdateString?
        public let alias: UpdateString?
    }
}

// MARK: - Responses -

public extension Procedure.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Create: Responsable {
        public let procedures: [Procedure.Helpers.CreateProcedureResponse]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct All: Responsable {
        public let procedures: [Procedure.Helpers.AllProcedureResponse]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Update: Responsable {
        public let id: UUID
        public let price: Price
        public let duration: Minutes
        public let description: String?
        public let alias: String?
        public let parameters: [Procedure.Helpers.ParameterResponse]
        public let serviceId: UUID
        public let serviceTags: [TranslatedServiceTag]
        public let serviceTitle: String
        public let masterId: UUID
        public let masterNickname: String
        public let masterAvatar: URL?
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Retrieve: Responsable {
        public let id: UUID
        public let duration: Minutes
        public let price: Price
        public let alias: String?
        public let description: String?
        public let parameters: [Procedure.Helpers.ParameterResponse]
        public let serviceId: UUID
        public let serviceTags: [TranslatedServiceTag]
        public let serviceTitle: String
        public let masterId: UUID
        public let masterNickname: String
        public let masterAvatar: URL?
    }
}

public extension Procedure.Helpers {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct CreateParameterRequest: Codable {
        public let id: UUID
        public let optional: Bool
        public let cases: [CreateCaseRequest]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct CreateCaseRequest: Codable {
        public let id: Int
        public let casePrice: CasePrice?
        public let caseDuration: CaseDuration?
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct CreateProcedureResponse: Codable {
        public let id: UUID
        public let duration: Minutes
        public let price: Price
        public let alias: String?
        public let description: String?
        public let parameters: [Procedure.Helpers.ParameterResponse]
        public let serviceId: UUID
        public let serviceTags: [TranslatedServiceTag]
        public let serviceTitle: String
        public let masterId: UUID
        public let masterNickname: String
        public let masterAvatar: URL?
    }
}

public extension Procedure.Helpers  {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct AllProcedureResponse: Codable {
        public let id: UUID
        public let duration: Minutes
        public let price: Price
        public let alias: String?
        public let description: String?
        public let parameters: [Procedure.Helpers.ParameterResponse]
        public let serviceId: UUID
        public let serviceTags: [TranslatedServiceTag]
        public let serviceTitle: String
        public let masterId: UUID
        public let masterNickname: String
        public let masterAvatar: URL?
    }
}

public extension Procedure.Helpers {
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct ParameterResponse: Codable {
        public let id: UUID
        public let optional: Bool
        public let title: String
        public let cases: [CaseResponse]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct CaseResponse: Codable {
        public let id: Int
        public let title: String
        public let price: CasePrice?
        public let duration: CaseDuration?
    }
    
    enum CasePrice: Codable {
        case fixedValue(Decimal)
        case multiKoeff(Decimal)
        
        private enum CodingKeys: String, CodingKey {
            case fixedValue
            case multiKoeff
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            if let value = try? container.decode(Decimal.self, forKey: .fixedValue) {
                self = .fixedValue(value)
            } else if let value = try? container.decode(Decimal.self, forKey: .multiKoeff) {
                self = .multiKoeff(value)
            } else {
                throw DecodingError.dataCorruptedError(
                    forKey: CodingKeys.fixedValue,
                    in: container,
                    debugDescription: "Unable to decode Foo enum"
                )
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case .fixedValue(let value):
                try container.encode(value, forKey: .fixedValue)
            case .multiKoeff(let value):
                try container.encode(value, forKey: .multiKoeff)
            }
        }
    }
    
    enum CaseDuration: Codable {
        case fixedValue(Minutes)
        case multiKoeff(Decimal)
        
        private enum CodingKeys: String, CodingKey {
            case fixedValue
            case multiKoeff
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            if let value = try? container.decode(Minutes.self, forKey: .fixedValue) {
                self = .fixedValue(value)
            } else if let value = try? container.decode(Decimal.self, forKey: .multiKoeff) {
                self = .multiKoeff(value)
            } else {
                throw DecodingError.dataCorruptedError(
                    forKey: CodingKeys.fixedValue,
                    in: container,
                    debugDescription: "Unable to decode Foo enum"
                )
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case .fixedValue(let value):
                try container.encode(value, forKey: .fixedValue)
            case .multiKoeff(let value):
                try container.encode(value, forKey: .multiKoeff)
            }
        }
    }
}
