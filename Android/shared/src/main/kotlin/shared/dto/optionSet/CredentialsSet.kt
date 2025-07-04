package shared.dto.optionSet

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
class CredentialsSet {
    var clientCreds      : MutableSet<ClientCredentials> = mutableSetOf()
    var salonCreds       : MutableSet<SalonCredentials> = mutableSetOf()
    var employeeCreds    : MutableSet<EmployeeCredentials> = mutableSetOf()
    var procedureCreds   : MutableSet<ProcedureCredentials> = mutableSetOf()
    var positionCreds    : MutableSet<PositionCredentials> = mutableSetOf()
    var worktimeCreds    : MutableSet<WorktimeCredentials> = mutableSetOf()
    var appointmentCreds : MutableSet<AppointmentCredentials> = mutableSetOf()
    var statisticCreds   : MutableSet<StatisticCredentials> = mutableSetOf()
    var notificationCreds: MutableSet<NotificationCredentials> = mutableSetOf()
    var financeCreds     : MutableSet<FinanceCredentials> = mutableSetOf()
    var salaryCreds      : MutableSet<SalaryCredentials> = mutableSetOf()

    companion object{
        fun all(): CredentialsSet {
            var set = CredentialsSet()
            set.clientCreds = ClientCredentials.entries.toMutableSet()
            set.salonCreds = SalonCredentials.entries.toMutableSet()
            set.employeeCreds = EmployeeCredentials.entries.toMutableSet()
            set.procedureCreds = ProcedureCredentials.entries.toMutableSet()
            set.positionCreds = PositionCredentials.entries.toMutableSet()
            set.worktimeCreds = WorktimeCredentials.entries.toMutableSet()
            set.appointmentCreds = AppointmentCredentials.entries.toMutableSet()
            set.statisticCreds = StatisticCredentials.entries.toMutableSet()
            set.notificationCreds = NotificationCredentials.entries.toMutableSet()
            set.financeCreds = FinanceCredentials.entries.toMutableSet()
            set.salaryCreds = SalaryCredentials.entries.toMutableSet()
            return set
        }

        fun none(): CredentialsSet {
            return CredentialsSet()
        }
    }

    public fun add(c: ClientCredentials)      : Boolean { return this.clientCreds.add(c) }
    public fun add(c: SalonCredentials)       : Boolean { return this.salonCreds.add(c) }
    public fun add(c: EmployeeCredentials)    : Boolean { return this.employeeCreds.add(c) }
    public fun add(c: ProcedureCredentials)   : Boolean { return this.procedureCreds.add(c) }
    public fun add(c: PositionCredentials)    : Boolean { return this.positionCreds.add(c) }
    public fun add(c: WorktimeCredentials)    : Boolean { return this.worktimeCreds.add(c) }
    public fun add(c: AppointmentCredentials) : Boolean { return this.appointmentCreds.add(c) }
    public fun add(c: StatisticCredentials)   : Boolean { return this.statisticCreds.add(c) }
    public fun add(c: NotificationCredentials): Boolean { return this.notificationCreds.add(c) }
    public fun add(c: FinanceCredentials)     : Boolean { return this.financeCreds.add(c) }
    public fun add(c: SalaryCredentials)      : Boolean { return this.salaryCreds.add(c) }

    public fun remove(c: ClientCredentials)      : Boolean { return this.clientCreds.remove(c) }
    public fun remove(c: SalonCredentials)       : Boolean { return this.salonCreds.remove(c) }
    public fun remove(c: EmployeeCredentials)    : Boolean { return this.employeeCreds.remove(c) }
    public fun remove(c: ProcedureCredentials)   : Boolean { return this.procedureCreds.remove(c) }
    public fun remove(c: PositionCredentials)    : Boolean { return this.positionCreds.remove(c) }
    public fun remove(c: WorktimeCredentials)    : Boolean { return this.worktimeCreds.remove(c) }
    public fun remove(c: AppointmentCredentials) : Boolean { return this.appointmentCreds.remove(c) }
    public fun remove(c: StatisticCredentials)   : Boolean { return this.statisticCreds.remove(c) }
    public fun remove(c: NotificationCredentials): Boolean { return this.notificationCreds.remove(c) }
    public fun remove(c: FinanceCredentials)     : Boolean { return this.financeCreds.remove(c) }
    public fun remove(c: SalaryCredentials)      : Boolean { return this.salaryCreds.remove(c) }

    public fun contains(c: ClientCredentials)      : Boolean { return this.clientCreds.contains(c) }
    public fun contains(c: SalonCredentials)       : Boolean { return this.salonCreds.contains(c) }
    public fun contains(c: EmployeeCredentials)    : Boolean { return this.employeeCreds.contains(c) }
    public fun contains(c: ProcedureCredentials)   : Boolean { return this.procedureCreds.contains(c) }
    public fun contains(c: PositionCredentials)    : Boolean { return this.positionCreds.contains(c) }
    public fun contains(c: WorktimeCredentials)    : Boolean { return this.worktimeCreds.contains(c) }
    public fun contains(c: AppointmentCredentials) : Boolean { return this.appointmentCreds.contains(c) }
    public fun contains(c: StatisticCredentials)   : Boolean { return this.statisticCreds.contains(c) }
    public fun contains(c: NotificationCredentials): Boolean { return this.notificationCreds.contains(c) }
    public fun contains(c: FinanceCredentials)     : Boolean { return this.financeCreds.contains(c) }
    public fun contains(c: SalaryCredentials)      : Boolean { return this.salaryCreds.contains(c) }

    enum class ClientCredentials {
        @SerialName("edit")
        EDIT,

        @SerialName("visibleBaseInfo")
        VISIBLE_BASE_INFO,

        @SerialName("visibleContacts")
        VISIBLE_CONTACTS,
    }

    enum class SalonCredentials {
        @SerialName("editBaseInfo")
        EDIT_BASE_INFO,
    }

    enum class EmployeeCredentials {
        @SerialName("edit")
        EDIT,

        @SerialName("visible")
        VISIBLE,
    }

    enum class ProcedureCredentials {
        @SerialName("ownEdit")
        OWN_EDIT,

        @SerialName("otherEdit")
        OTHER_EDIT,
    }

    enum class PositionCredentials {
        @SerialName("edit")
        EDIT,
    }

    enum class WorktimeCredentials {
        @SerialName("ownEdit")
        OWN_EDIT,

        @SerialName("otherEdit")
        OTHER_EDIT,
    }

    enum class AppointmentCredentials {
        @SerialName("all")
        ALL,
    }

    enum class StatisticCredentials {
        @SerialName("all")
        ALL,
    }

    enum class NotificationCredentials {
        @SerialName("all")
        ALL,
    }

    enum class FinanceCredentials {
        @SerialName("all")
        ALL,
    }

    enum class SalaryCredentials {
        @SerialName("all")
        ALL,
    }
}