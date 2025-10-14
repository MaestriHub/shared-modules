/// Если вы правите это обязательно поправьте маппер в приложении.
public struct CredentialsSet: Codable, Hashable, Sendable {
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
    
    public enum ClientCredentials: String, Codable, Sendable {
        case edit
        case visibleBaseInfo
        case visibleContacts
    }

    public enum SalonCredentials: String, Codable, Sendable {
        case editBaseInfo
    }

    public enum EmployeeCredentials: String, Codable, Sendable {
        case edit
        case visible
    }

    public enum ProcedureCredentials: String, Codable, Sendable {
        case ownEdit
        case otherEdit
    }

    public enum PositionCredentials: String, Codable, Sendable {
        case edit
    }

    public enum WorktimeCredentials: String, Codable, Sendable {
        case ownEdit
        case otherEdit
    }

    /// ----------------------

    public enum AppointmentCredentials: String, Codable, Sendable {
       case all
    }

    public enum StatisticCredentials: String, Codable, Sendable {
        case all
    }

    public enum NotificationCredentials: String, Codable, Sendable {
        case all
    }

    public enum FinanceCredentials: String, Codable, Sendable {
        case all
    }

    public enum SalaryCredentials: String, Codable, Sendable {
        case all
    }
}

public extension CredentialsSet {
    nonisolated(unsafe) static var all: CredentialsSet = .init(
        clientCreds     : [.edit, .visibleBaseInfo, .visibleContacts],
        salonCreds      : [.editBaseInfo],
        employeeCreds   : [.edit, .visible],
        procedureCreds  : [.otherEdit, .ownEdit],
        positionCreds   : [.edit],
        worktimeCreds   : [.otherEdit, .ownEdit],
        appointmentCreds: [.all],
        statisticCreds  : [.all],
        notifyCreds     : [.all],
        financeCreds    : [.all],
        salaryCreds     : [.all]
    )
    
    nonisolated(unsafe) static var none: CredentialsSet = .init(
        clientCreds     : [],
        salonCreds      : [],
        employeeCreds   : [],
        procedureCreds  : [],
        positionCreds   : [],
        worktimeCreds   : [],
        appointmentCreds: [],
        statisticCreds  : [],
        notifyCreds     : [],
        financeCreds    : [],
        salaryCreds     : []
    )
}

public extension CredentialsSet {
    mutating func insert(_ c: ClientCredentials)       { self.clientCreds.insert(c) }
    mutating func insert(_ c: SalonCredentials)        { self.salonCreds.insert(c) }
    mutating func insert(_ c: EmployeeCredentials)     { self.employeeCreds.insert(c) }
    mutating func insert(_ c: ProcedureCredentials)    { self.procedureCreds.insert(c) }
    mutating func insert(_ c: PositionCredentials)     { self.positionCreds.insert(c) }
    mutating func insert(_ c: WorktimeCredentials)     { self.worktimeCreds.insert(c) }
    mutating func insert(_ c: AppointmentCredentials)  { self.appointmentCreds.insert(c) }
    mutating func insert(_ c: StatisticCredentials)    { self.statisticCreds.insert(c) }
    mutating func insert(_ c: NotificationCredentials) { self.notifyCreds.insert(c) }
    mutating func insert(_ c: SalaryCredentials)       { self.salaryCreds.insert(c) }
    mutating func insert(_ c: FinanceCredentials)      { self.financeCreds.insert(c) }
    
    mutating func remove(_ c: ClientCredentials)       { self.clientCreds.remove(c) }
    mutating func remove(_ c: SalonCredentials)        { self.salonCreds.remove(c) }
    mutating func remove(_ c: EmployeeCredentials)     { self.employeeCreds.remove(c) }
    mutating func remove(_ c: ProcedureCredentials)    { self.procedureCreds.remove(c) }
    mutating func remove(_ c: PositionCredentials)     { self.positionCreds.remove(c) }
    mutating func remove(_ c: WorktimeCredentials)     { self.worktimeCreds.remove(c) }
    mutating func remove(_ c: AppointmentCredentials)  { self.appointmentCreds.remove(c) }
    mutating func remove(_ c: StatisticCredentials)    { self.statisticCreds.remove(c) }
    mutating func remove(_ c: NotificationCredentials) { self.notifyCreds.remove(c) }
    mutating func remove(_ c: SalaryCredentials)       { self.salaryCreds.remove(c) }
    mutating func remove(_ c: FinanceCredentials)      { self.financeCreds.remove(c) }
    
    mutating func contains(_ c: ClientCredentials)       -> Bool { self.clientCreds.contains(c) }
    mutating func contains(_ c: SalonCredentials)        -> Bool { self.salonCreds.contains(c) }
    mutating func contains(_ c: EmployeeCredentials)     -> Bool { self.employeeCreds.contains(c) }
    mutating func contains(_ c: ProcedureCredentials)    -> Bool { self.procedureCreds.contains(c) }
    mutating func contains(_ c: PositionCredentials)     -> Bool { self.positionCreds.contains(c) }
    mutating func contains(_ c: WorktimeCredentials)     -> Bool { self.worktimeCreds.contains(c) }
    mutating func contains(_ c: AppointmentCredentials)  -> Bool { self.appointmentCreds.contains(c) }
    mutating func contains(_ c: StatisticCredentials)    -> Bool { self.statisticCreds.contains(c) }
    mutating func contains(_ c: NotificationCredentials) -> Bool { self.notifyCreds.contains(c) }
    mutating func contains(_ c: SalaryCredentials)       -> Bool { self.salaryCreds.contains(c) }
    mutating func contains(_ c: FinanceCredentials)      -> Bool { self.financeCreds.contains(c) }
}
