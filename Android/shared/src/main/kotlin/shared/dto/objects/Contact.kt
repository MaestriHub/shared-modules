@file:UseSerializers(UUIDSerializer::class)

package com.maestri.sdk.sources.shared.dto.objects


import shared.dto.enums.`ContactType ✅`
import com.maestri.sdk.sources.shared.dto.protocols.Parametable
import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.UUID

/// Пространство имен `Contact` содержит типы данных для работы с записями на прием.
///
/// В него входят как параметры для запросов (`Parameters`), так и модели ответов (`Responses`),
/// которые используются для сериализации данных, отправляемых и получаемых от API.
object Contact {
    // MARK: - Parameters -
    data object Parameters {
        /// Параметры для создания контакта.
        /// Включает в себя информацию, необходимую для регистрации нового контактного метода.
        ///
        /// ### Properties:
        /// - `value`: Значение контактного данных, например номер телефона или адрес электронной почты.
        /// - `type`: Тип контактного метода, определенный в ``ContactType``.
        @Serializable
        data class Create(
            val value: String,
            val type: `ContactType ✅`,
            val isVerify: Boolean?,
        ) : Parametable()

        /// Параметры для отправки OTP кода на указанный контакт
        ///
        /// ### Properties:
        /// - recaptchaToken: `String?` - токен полученный от сайта с reCaptcha
        @Serializable
        data class SendCode(
            val recaptchaToken: String?,
        ) : Parametable()

        /// Параметры `Verify` используются для отправки верификационного кода на значение контакта.
        ///
        /// ### Properties:
        /// - code: `String` - код отправленный ранее на значение контакта
        @Serializable
        data class Verify(
            val code: String,
        ) : Parametable()
    }

    // MARK: - Responses -
    data object Responses {
        /// Полная информация о контакте.
        /// Возвращает данные контакта, включая его идентификационный номер и статус верификации.
        ///
        /// ### Properties:
        /// - `id`: Уникальный идентификатор контакта.
        /// - `value`: Значение контактного метода.
        /// - `isVerify`: Статус верификации контакта.
        /// - `type`: Тип контактного метода, определенный в ``ContactType``.
        @Serializable
        data class Full(
            val id: UUID,
            val value: String,
            val isVerify: Boolean,
            val type: `ContactType ✅`,
        ) : Responsable

        /// `Verify` возвращает информацию о том, что контакт был верифицирован
        ///
        /// ### Properties:
        /// - isVeried: `Bool` - поле, обозначающее что контакт верифицирован
        @Serializable
        data class Verify(
            val isVerified: Boolean,
        ) : Responsable
    }
}
