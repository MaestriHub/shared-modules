package shared.dto.optionSet

import com.maestri.sdk.sources.shared.serializers.PermissionSetSerializer
import kotlinx.serialization.Serializable

@Serializable(PermissionSetSerializer::class)
@JvmInline
value class PermissionSet(private val rawValue: Int) {
    companion object {
        val owner = PermissionSet(1 shl 0)
        val appointments = PermissionSet(1 shl 1)
        val statistic = PermissionSet(1 shl 2)
        val employee = PermissionSet(1 shl 3)
        val timetable = PermissionSet(1 shl 4)
        val notifications = PermissionSet(1 shl 5)
        val salon = PermissionSet(1 shl 6)
        val finance = PermissionSet(1 shl 7)
        val procedure = PermissionSet(1 shl 8)
        val contact = PermissionSet(1 shl 9)
        val position = PermissionSet(1 shl 10)
        val salary = PermissionSet(1 shl 11)

        val none = PermissionSet(0)
        val all = PermissionSet(
            appointments.rawValue or
                    statistic.rawValue or
                    employee.rawValue or
                    timetable.rawValue or
                    notifications.rawValue or
                    salon.rawValue or
                    finance.rawValue or
                    procedure.rawValue or
                    contact.rawValue or
                    position.rawValue or
                    salary.rawValue
        )

//        fun of(valarg permissions: PermissionSet): PermissionSet {
//            val combined = 0
//            for (permission in permissions) {
//                combined = combined or permission.rawValue
//            }
//            return PermissionSet(combined)
//        }
    }

    operator fun contains(permission: PermissionSet): Boolean {
        return rawValue and permission.rawValue != 0
    }

    operator fun plus(permission: PermissionSet): PermissionSet {
        return PermissionSet(rawValue or permission.rawValue)
    }

    operator fun minus(permission: PermissionSet): PermissionSet {
        return PermissionSet(rawValue and permission.rawValue.inv())
    }
}