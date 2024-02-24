//
//  TimetableOwner.swift
//  Created by Vitalii Shevtsov on 2/20/24.
//

import Foundation

public enum TimetableOwner: Parametable, Responsable, LosslessStringConvertible, Equatable {
        
    case salon(id: UUID)
    case employee(id: UUID)
    
    public init?(_ description: String) {
        let splited = description.split(separator: ":")
        switch splited.first {
        case "salon":
            if let uuidString = splited.last, let uuid = UUID(uuidString: String(uuidString)) {
                self = .salon(id: uuid)
            } else {
                return nil
            }
        case "employee":
            if let uuidString = splited.last, let uuid = UUID(uuidString: String(uuidString)) {
                self = .employee(id: uuid)
            } else {
                return nil
            }
        default: return nil
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
}
