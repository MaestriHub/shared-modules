@file:UseSerializers(UUIDSerializer::class)

package com.maestri.sdk.sources.shared.dto.objects

import shared.dto.enums.CustomerUser
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.objects.Contact
import java.util.UUID

/// Пространство имен `Customer` содержит типы данных для работы с информацией о клиентах.
///
/// В него входят параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обмена данными между клиентом и сервером в контексте клиентских данных.
object Customer {
    data object Parameters {
        @Serializable
        data class Registration(
            var contacts: List<Contact.Parameters.Create>,
        ) : Parametable()

        @Serializable
        data class Create(
            var salonId: UUID?,
            var alias: String,
            var contacts: List<Contact.Parameters.Create>,
        ) : Parametable()

        @Serializable
        data class Retrieve(
            val salons: List<UUID>?,
            val employees: List<UUID>?,
        ) : Parametable()

        @Serializable
        data class HandleInvite(
            var contact: String?,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            var id: UUID,
            var user: CustomerUser,
            var alias: String?,
            var contacts: List<Contact.Responses.Full>,
        ) : Responsable

        @Serializable
        data class Partial(
            @Serializable(with = UUIDSerializer::class) var id: UUID,
            var user: CustomerUser,
            var alias: String?,
            var contacts: List<Contact.Responses.Full>,
        ) : Responsable

        @Serializable
        data class Verify(
            var contacts: List<Contact.Responses.Full>,
        ) : Responsable
    }
}
