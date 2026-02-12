@file:UseSerializers(UUIDSerializer::class)

package shared.dto.enums

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.objects.procedure.ChunkId
import shared.dto.protocols.Responsable
import shared.serializers.AppointmentTypeSerializer
import shared.serializers.UUIDSerializer
import java.util.*

typealias ProcedureId = UUID

@Serializable(AppointmentTypeSerializer::class)
sealed class AppointmentType : Responsable {
    @Serializable
    data class Complex(
        val id: UUID,
        val order: Map<ChunkId, ProcedureId>
    ) : AppointmentType()

    @Serializable
    data class Procedure(
        val id: UUID,
    ) : AppointmentType()
}