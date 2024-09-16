//
//  TimetableOwner.swift
//  Created by Vitalii Shevtsov on 2/20/24.
//

import Foundation

public enum TimetableOwner: Parametable, Responsable, LosslessStringConvertible, Equatable {
    
    case salon(id: UUID)
    case employee(id: UUID)
    
    public init?(_ description: String) {
        try? self.init(value: description)
    }
    
    public init(value: String) throws {
        let splited = value.split(separator: ":")
        switch splited.first {
        case "salon":
            if let uuidString = splited.last, let uuid = UUID(uuidString: String(uuidString)) {
                self = .salon(id: uuid)
            } else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: ""))
            }
        case "employee":
            if let uuidString = splited.last, let uuid = UUID(uuidString: String(uuidString)) {
                self = .employee(id: uuid)
            } else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: ""))
            }
        default: throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: ""))
        }
    }
    
    public var description: String {
        switch self {
        case .salon(let id):
            return "salon:\(id)"
        case .employee(let id):
            return "employee:\(id)"
        }
    }
    
    //MARK: Codable
    
    public init(from decoder: any Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)
        try self.init(value: value)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }
}
