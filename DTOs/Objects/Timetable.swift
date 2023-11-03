import Foundation
import SwifCron

/// Namespace для всех DTOs относящихся к Timetable
public enum Timetable {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Timetable.Parameters {
    
    struct Create: Parametable {
        
        public var timeZone: String
        
        public var limit: DateInterval?
    }
    
    struct Patch: Parametable {
        public var nickname: String?
        public var avatar: String?
    }
}

//MARK: - Responses -

public extension Timetable.Responses {
    
    struct Full: Responsable {
        public var id: UUID?
        public var timeZone: String
        
        public var limit: Interval?
    }
    
    struct Partial: Responsable {
        public var id: UUID?
        public var name: String
    }
    
    struct Slot: Responsable {
        
    }
}
