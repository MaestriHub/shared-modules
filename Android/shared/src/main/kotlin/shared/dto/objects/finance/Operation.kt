@file:UseSerializers(UUIDSerializer::class, DateSerializer::class)

package com.maestri.sdk.sources.shared.dto.objects.finance

import shared.dto.enums.OperationType
import com.maestri.sdk.sources.shared.dto.enums.PaymentType
import com.maestri.sdk.sources.shared.dto.primitives.Price
import com.maestri.sdk.sources.shared.dto.protocols.Parametable
import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.DateSerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.Date
import java.util.UUID

object Operation {
    //MARK: - Parameters -
    data object Parameters {
        @Serializable
        data class Create(
            val price: Price,
            val operationType: OperationType,
            val paymentType: PaymentType,
            val salonId: UUID,
        ) : Parametable()

        @Serializable
        data class Retrieve(
            @Serializable(DateSerializer::class) val startDate: Date?,
            @Serializable(DateSerializer::class) val endDate: Date?,
            val paymentType: PaymentType?,
            val cashboxIds: List<UUID>?,
        ) : Parametable()
    }

    //MARK: - Responses -
    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
            val createDate: Date,
            val price: Price,
            val paymentType: PaymentType,
        ) : Responsable
    }
}
