@file:UseSerializers(UUIDSerializer::class, DateSerializer::class)

package com.maestri.sdk.sources.shared.dto.objects.finance

import shared.dto.enums.`PaymentType ✅`
import com.maestri.sdk.sources.shared.dto.protocols.Parametable
import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.DateSerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.Date
import java.util.UUID

object Cashbox {
    //MARK: - Parameters -
    data object Parameters {

        @Serializable
        data class Create(
            val salonId: UUID,
            val paymentType: `PaymentType ✅`,
        ) : Parametable()

        @Serializable
        data class Retrieve(
            val paymentType: `PaymentType ✅`?,
            val startDate: Date?,
            val endDate: Date?,
        ) : Parametable()
    }

    //MARK: - Responses -
    data object Responses {

        data class Full(
            val id: UUID,
            val createDate: Date,
            val paymentType: `PaymentType ✅`,
        ) : Responsable
    }
}
