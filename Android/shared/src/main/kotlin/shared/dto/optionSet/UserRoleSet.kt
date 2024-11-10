package shared.dto.optionSet

import com.maestri.sdk.sources.shared.serializers.UserRoleSetSerializer
import kotlinx.serialization.Serializable

@Serializable(UserRoleSetSerializer::class)
@JvmInline
value class UserRoleSet(private val rawValue: Int) {
    companion object {
        val customer = UserRoleSet(1 shl 0)
        val professional = UserRoleSet(1 shl 1)

        val all: UserRoleSet = UserRoleSet(customer.rawValue or professional.rawValue)
    }

    operator fun contains(permission: UserRoleSet): Boolean {
        return rawValue and permission.rawValue != 0
    }

    operator fun plus(permission: UserRoleSet): UserRoleSet {
        return UserRoleSet(rawValue or permission.rawValue)
    }

    operator fun minus(permission: UserRoleSet): UserRoleSet {
        return UserRoleSet(rawValue and permission.rawValue.inv())
    }
}