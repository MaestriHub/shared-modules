package shared.dto.optionSet

import com.maestri.sdk.sources.shared.serializers.MaestriPermissionSetSerializer
import kotlinx.serialization.Serializable

@Serializable(MaestriPermissionSetSerializer::class)
@JvmInline
value class `MaestriPermissionSet ✅`(private val rawValue: Int) {
    companion object {
        val none: `MaestriPermissionSet ✅` = `MaestriPermissionSet ✅`(0)
        val service = `MaestriPermissionSet ✅`(1 shl 0)

        val full: `MaestriPermissionSet ✅` = `MaestriPermissionSet ✅`(
            service.rawValue
        )
    }

    operator fun contains(permission: `MaestriPermissionSet ✅`): Boolean {
        return rawValue and permission.rawValue != 0
    }

    operator fun plus(permission: `MaestriPermissionSet ✅`): `MaestriPermissionSet ✅` {
        return `MaestriPermissionSet ✅`(rawValue or permission.rawValue)
    }

    operator fun minus(permission: `MaestriPermissionSet ✅`): `MaestriPermissionSet ✅` {
        return `MaestriPermissionSet ✅`(rawValue and permission.rawValue.inv())
    }
}