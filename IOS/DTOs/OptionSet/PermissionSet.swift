public struct CredentialsSet: Codable, Hashable {
    public var clientCreds     : Set<ClientCredentials>
    public var salonCreds      : Set<SalonCredentials>
    public var employeeCreds   : Set<EmployeeCredentials>
    public var procedureCreds  : Set<ProcedureCredentials>
    public var positionCreds   : Set<PositionCredentials>
    public var worktimeCreds   : Set<WorktimeCredentials>
    public var appointmentCreds: Set<AppointmentCredentials>
    public var statisticCreds  : Set<StatisticCredentials>
    public var notifyCreds     : Set<NotificationCredentials>
    public var financeCreds    : Set<FinanceCredentials>
    public var salaryCreds     : Set<SalaryCredentials>
    
    public enum ClientCredentials: Codable {
        case edit
        case visibleBaseInfo
        case visibleContacts
    }

    public enum SalonCredentials: Codable {
        case editBaseInfo
    }

    public enum EmployeeCredentials: Codable {
        case edit
        case visible
    }

    public enum ProcedureCredentials: Codable {
        case ownCreate
        case otherCreate
    }

    public enum PositionCredentials: Codable {
        case edit
    }

    public enum WorktimeCredentials: Codable {
        case ownEdit
        case otherEdit
    }

    /// ----------------------

    public enum AppointmentCredentials: Codable {
       case all
    }

    public enum StatisticCredentials: Codable {
        case all
    }

    public enum NotificationCredentials: Codable {
        case all
    }

    public enum FinanceCredentials: Codable {
        case all
    }

    public enum SalaryCredentials: Codable {
        case all
    }
}

public extension CredentialsSet {
    static var all: CredentialsSet = .init(
        clientCreds: [.edit, .visibleBaseInfo, .visibleContacts],
        salonCreds: [.editBaseInfo],
        employeeCreds: [.edit, .visible],
        procedureCreds: [.otherCreate, .ownCreate],
        positionCreds: [.edit],
        worktimeCreds: [.otherEdit, .ownEdit],
        appointmentCreds: [.all],
        statisticCreds: [.all],
        notifyCreds: [.all],
        financeCreds: [.all],
        salaryCreds: [.all]
    )
    
    static var none: CredentialsSet = .init(
        clientCreds: [],
        salonCreds: [],
        employeeCreds: [],
        procedureCreds: [],
        positionCreds: [],
        worktimeCreds: [],
        appointmentCreds: [],
        statisticCreds: [],
        notifyCreds: [],
        financeCreds: [],
        salaryCreds: []
    )
}

public extension CredentialsSet {
    mutating func insert(c: ClientCredentials)       { self.clientCreds.insert(c) }
    mutating func insert(c: SalonCredentials)        { self.salonCreds.insert(c) }
    mutating func insert(c: EmployeeCredentials)     { self.employeeCreds.insert(c) }
    mutating func insert(c: ProcedureCredentials)    { self.procedureCreds.insert(c) }
    mutating func insert(c: PositionCredentials)     { self.positionCreds.insert(c) }
    mutating func insert(c: WorktimeCredentials)     { self.worktimeCreds.insert(c) }
    mutating func insert(c: AppointmentCredentials)  { self.appointmentCreds.insert(c) }
    mutating func insert(c: StatisticCredentials)    { self.statisticCreds.insert(c) }
    mutating func insert(c: NotificationCredentials) { self.notifyCreds.insert(c) }
    mutating func insert(c: SalaryCredentials)       { self.salaryCreds.insert(c) }
    mutating func insert(c: FinanceCredentials)      { self.financeCreds.insert(c) }
    
    mutating func remove(c: ClientCredentials)       { self.clientCreds.remove(c) }
    mutating func remove(c: SalonCredentials)        { self.salonCreds.remove(c) }
    mutating func remove(c: EmployeeCredentials)     { self.employeeCreds.remove(c) }
    mutating func remove(c: ProcedureCredentials)    { self.procedureCreds.remove(c) }
    mutating func remove(c: PositionCredentials)     { self.positionCreds.remove(c) }
    mutating func remove(c: WorktimeCredentials)     { self.worktimeCreds.remove(c) }
    mutating func remove(c: AppointmentCredentials)  { self.appointmentCreds.remove(c) }
    mutating func remove(c: StatisticCredentials)    { self.statisticCreds.remove(c) }
    mutating func remove(c: NotificationCredentials) { self.notifyCreds.remove(c) }
    mutating func remove(c: SalaryCredentials)       { self.salaryCreds.remove(c) }
    mutating func remove(c: FinanceCredentials)      { self.financeCreds.remove(c) }
    
    mutating func contains(c: ClientCredentials)       -> Bool { self.clientCreds.contains(c) }
    mutating func contains(c: SalonCredentials)        -> Bool { self.salonCreds.contains(c) }
    mutating func contains(c: EmployeeCredentials)     -> Bool { self.employeeCreds.contains(c) }
    mutating func contains(c: ProcedureCredentials)    -> Bool { self.procedureCreds.contains(c) }
    mutating func contains(c: PositionCredentials)     -> Bool { self.positionCreds.contains(c) }
    mutating func contains(c: WorktimeCredentials)     -> Bool { self.worktimeCreds.contains(c) }
    mutating func contains(c: AppointmentCredentials)  -> Bool { self.appointmentCreds.contains(c) }
    mutating func contains(c: StatisticCredentials)    -> Bool { self.statisticCreds.contains(c) }
    mutating func contains(c: NotificationCredentials) -> Bool { self.notifyCreds.contains(c) }
    mutating func contains(c: SalaryCredentials)       -> Bool { self.salaryCreds.contains(c) }
    mutating func contains(c: FinanceCredentials)      -> Bool { self.financeCreds.contains(c) }
}
