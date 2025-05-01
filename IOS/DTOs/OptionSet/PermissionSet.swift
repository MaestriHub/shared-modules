public struct CredentialsSet: OptionSet, Codable, Hashable {
    public var rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public enum Client {
        static let edit = CredentialsSet(rawValue: 0)
        static let visibleBaseInfo = CredentialsSet(rawValue: 1)
        static let visibleContacts = CredentialsSet(rawValue: 2)
    }
    
    public enum Salon {
        static let editBaseInfo = CredentialsSet(rawValue: 3)
    }
    
    public enum Employee {
        static let edit = CredentialsSet(rawValue: 4)
        static let visible = CredentialsSet(rawValue: 5)
    }
    
    public enum Procedure {
        static let ownCreate = CredentialsSet(rawValue: 6)
        static let otherCreate = CredentialsSet(rawValue: 7)
    }
    
    public enum Position {
        static let edit = CredentialsSet(rawValue: 8)
    }
    
    public enum Worktime {
        static let ownEdit = CredentialsSet(rawValue: 9)
        static let otherEdit = CredentialsSet(rawValue: 10)
    }
    
    /// ----------------------
    
    public enum Appointment {
        static let all = CredentialsSet(rawValue: 11)
    }
    
    public enum Statistic {
        static let all = CredentialsSet(rawValue: 12)
    }
    
    public enum Notification {
        static let all = CredentialsSet(rawValue: 13)
    }
    
    public enum Finance {
        static let all = CredentialsSet(rawValue: 14)
    }
    
    public enum Salary {
        static let all = CredentialsSet(rawValue: 15)
    }
}

public extension CredentialsSet {
    static let none: CredentialsSet = []
    
    static let all: CredentialsSet = [
        Client.edit,
        Client.visibleBaseInfo,
        Client.visibleContacts,
        
        Salon.editBaseInfo,
        
        Employee.edit,
        Employee.visible,
        
        Procedure.otherCreate,
        Procedure.ownCreate,
        
        Position.edit,
        
        Worktime.otherEdit,
        Worktime.ownEdit,
        
        Appointment.all,
        
        Statistic.all,
        
        Notification.all,
        
        Finance.all,
        
        Salary.all,
    ]
}
