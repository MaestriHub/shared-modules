@file:UseSerializers(UUIDSerializer::class, DateSerializer::class)

package com.maestri.sdk.sources.shared.dto.objects.finance

import shared.dto.enums.PaymentType
import shared.dto.primitives.Price
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.DateSerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.primitives.OperationInfo
import java.util.Date
import java.util.UUID

// MARK: Пока не используется и скорее всего будет дорабатываться финаносый блок
object Operation {
    data object Parameters {
        @Serializable
        data class Create(
            val price: Price,
            val paymentType: PaymentType,
            val salonId: UUID,
            val appointment: OperationInfo.AppointmentOperation? = null,
            val salary: OperationInfo.SalaryOperation? = null,
            val other: OperationInfo.OtherOperation? = null,
        ) : Parametable()

        @Serializable
        data class Retrieve(
            val startDate: Date?,
            val endDate: Date?,
            val paymentType: PaymentType?,
            val cashboxIds: List<UUID>?,
        ) : Parametable()
    }

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
