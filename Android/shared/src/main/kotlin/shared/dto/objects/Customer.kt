@file:UseSerializers(UUIDSerializer::class)

package com.maestri.sdk.sources.shared.dto.objects

import com.maestri.sdk.sources.shared.dto.enums.CustomerUser
import com.maestri.sdk.sources.shared.dto.protocols.Parametable
import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.UUID

/// Пространство имен `Customer` содержит типы данных для работы с информацией о клиентах.
///
/// В него входят параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обмена данными между клиентом и сервером в контексте клиентских данных.
object Customer {
    //MARK: - Parameters -
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

        /// Параметры запроса для получения списка клиентов.
        /// Позволяют фильтровать клиентов по определенным салонам.
        ///
        /// ### Properties:
        /// - `employees`: Список идентификаторов employees для фильтрации клиентов.
        @Serializable
        data class Retrieve(
            val salons: List<UUID>?,
            val employees: List<UUID>?,
        ) : Parametable()


        /// Параметры для частичного обновления профиля пользователя.
        ///
        /// ### Properties:
        ///  - contacts: Контактная информация Customer, для связи с ним
        @Serializable
        data class Patch(
            var contacts: List<Contact.Parameters.Create>,
        ) : Parametable()

        /// Параметры для того, чтобы принять приглашение в приложение.
        ///
        /// ### Properties:
        ///  - contact: value Контакта для верификации
        @Serializable
        data class HandleInvite(
            var contact: String?,
        ) : Parametable()
    }

    //MARK: - Responses -
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
