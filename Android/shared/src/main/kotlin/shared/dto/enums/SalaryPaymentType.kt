package shared.dto.enums

import shared.dto.primitives.Price
import shared.dto.protocols.Responsable
import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.jsonObject

@Serializable(SalaryPaymentType.Serializer::class)
sealed class SalaryPaymentType : Responsable {
    @Serializable
    data class Percent(
        val percent: Int,
    ) : SalaryPaymentType()

    @Serializable
    data class Value(
        val value: Price,
    ) : SalaryPaymentType()

    internal object Serializer :
        JsonContentPolymorphicSerializer<SalaryPaymentType>(SalaryPaymentType::class) {
        override fun selectDeserializer(element: JsonElement): DeserializationStrategy<SalaryPaymentType> {
            return when (element.jsonObject.contains("percent")) {
                true -> Percent.serializer()
                false -> Value.serializer()
            }
        }
    }
}