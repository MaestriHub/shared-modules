public struct CredentialsSet: OptionSet, Codable, Hashable {
    public var rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public enum Client {
        public static let edit = CredentialsSet(rawValue: 0)
        public static let visibleBaseInfo = CredentialsSet(rawValue: 1)
        public static let visibleContacts = CredentialsSet(rawValue: 2)
    }
    
    public enum Salon {
        public static let editBaseInfo = CredentialsSet(rawValue: 3)
    }
    
    public enum Employee {
        public static let edit = CredentialsSet(rawValue: 4)
        public static let visible = CredentialsSet(rawValue: 5)
    }
    
    public enum Procedure {
        public static let ownCreate = CredentialsSet(rawValue: 6)
        public static let otherCreate = CredentialsSet(rawValue: 7)
    }
    
    public enum Position {
        public static let edit = CredentialsSet(rawValue: 8)
    }
    
    public enum Worktime {
        public static let ownEdit = CredentialsSet(rawValue: 9)
        public static let otherEdit = CredentialsSet(rawValue: 10)
    }
    
    /// ----------------------
    
    public enum Appointment {
        public static let all = CredentialsSet(rawValue: 11)
    }
    
    public enum Statistic {
        public static let all = CredentialsSet(rawValue: 12)
    }
    
    public enum Notification {
        public static let all = CredentialsSet(rawValue: 13)
    }
    
    public enum Finance {
        public static let all = CredentialsSet(rawValue: 14)
    }
    
    public enum Salary {
        public static let all = CredentialsSet(rawValue: 15)
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
