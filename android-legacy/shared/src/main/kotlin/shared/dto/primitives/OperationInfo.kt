@file:UseSerializers(
    UUIDSerializer::class,
    DateISOSerializer::class
)

package shared.dto.primitives

import shared.serializers.DateISOSerializer
import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.UseSerializers
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.jsonObject
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer
import java.util.*

// DEPRECATED! пока не используется и это будет переделано 100%!
@Serializable
data class OperationInfo(
    val keys: Keys
) {
    @Serializable
    data class AppointmentOperation(
        val realizerId: UUID,
        val appointmentId: UUID,
    ) : Parametable(), Responsable

    @Serializable
    data class SalaryOperation(
        val initiatorId: UUID, // employeeId
        val receiverId: UUID, // employeeId
        val dateTo: Date, // Дата, Дальше которой все оплачено зарплатой
    ) : Parametable(), Responsable

    @Serializable
    data class OtherOperation(
        val realizerId: UUID,
        val descriptor: String,
    ) : Parametable(), Responsable

    @Serializable(Keys.Serializer::class)
    sealed class Keys : Responsable {
        @Serializable
        data class Appointment(
            val appointment: AppointmentOperation,
        ) : Keys()

        @Serializable
        data class Salary(
            val salary: SalaryOperation,
        ) : Keys()

        @Serializable
        data class Other(
            val other: OtherOperation,
        ) : Keys()

        internal object Serializer :
            JsonContentPolymorphicSerializer<Keys>(Keys::class) {
            override fun selectDeserializer(element: JsonElement): DeserializationStrategy<Keys> {
                val keys = element.jsonObject.keys
                return when {
                    "appointment" in keys -> Appointment.serializer()
                    "salary" in keys -> Salary.serializer()
                    "other" in keys -> Other.serializer()
                    else -> throw SerializationException("Unknown pattern type")
                }
            }
        }
    }
}
