@file:UseSerializers(UUIDSerializer::class)

package shared.dto.objects

import shared.dto.optionSet.PermissionSet
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.UUID

object Position {
    data object Parameters {
        @Serializable
        data class Create(
            val title: String,
            val permissions: PermissionSet,
            val salary: Salary.Parameters.Rules.Create,
        ) : Parametable()

        @Serializable
        data class Patch(
            val title: String?,
            val permissions: PermissionSet?,
            val salary: Salary.Parameters.Rules.Create,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
            val title: String,
            val permissions: PermissionSet,
            val salary: Salary.Responses.Rules.Full,
        ) : Responsable

        @Serializable
        data class Partial(
            val id: UUID,
            val title: String,
        ) : Responsable
    }
}