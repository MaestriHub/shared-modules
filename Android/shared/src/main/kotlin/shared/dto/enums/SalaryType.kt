@file:UseSerializers(UUIDSerializer::class)

package com.maestri.sdk.sources.shared.dto.enums

import com.maestri.sdk.sources.shared.dto.primitives.Price
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.jsonObject
import java.util.UUID

enum class PaymentPeriod {
    DAY,
    MONTH,
    HOUR
}

@Serializable(SalaryPaymentType.Serializer::class)
sealed class SalaryPaymentType {
    @Serializable
    data class Procent(val procent: UInt) : SalaryPaymentType()

    @Serializable
    data class Value(val value: Price) : SalaryPaymentType()

    internal object Serializer :
        JsonContentPolymorphicSerializer<SalaryPaymentType>(SalaryPaymentType::class) {
        override fun selectDeserializer(element: JsonElement): DeserializationStrategy<SalaryPaymentType> {
            return when (element.jsonObject.contains("value")) {
                true -> Value.serializer()
                false -> Procent.serializer()
            }
        }
    }
}

@Serializable(SalaryType.Serializer::class)
sealed class SalaryType {

    @Serializable
    data class Procent(
        val value: UInt,
    ) : SalaryType()

    @Serializable
    data class Grid(
        val proceduresMap: Map<UUID, SalaryPaymentType>,
    ) : SalaryType()

    @Serializable
    data class Wage(
        val price: Price,
        val period: PaymentPeriod,
    ) : SalaryType()

    @Serializable
    data object None : SalaryType()

    internal object Serializer : JsonContentPolymorphicSerializer<SalaryType>(SalaryType::class) {
        override fun selectDeserializer(element: JsonElement): DeserializationStrategy<SalaryType> =
            with(element.jsonObject) {
                return when {
                    contains("value") -> Procent.serializer()
                    contains("proceduresMap") -> Grid.serializer()
                    contains("price") -> Wage.serializer()
                    else -> None.serializer()
                }
            }
    }
}