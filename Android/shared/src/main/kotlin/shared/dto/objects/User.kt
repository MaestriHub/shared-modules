@file:UseSerializers(UUIDSerializer::class, URISerializer::class)

package com.maestri.sdk.sources.shared.dto.objects

import com.maestri.sdk.sources.shared.dto.optionSet.MaestriPermissionSet
import com.maestri.sdk.sources.shared.dto.optionSet.UserRoleSet
import com.maestri.sdk.sources.shared.dto.protocols.Parametable
import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.URISerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.net.URI
import java.util.UUID


/// Пространство имен `User` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
object User {
    // MARK: - Parameters -
    data object Parameters {
        /// Параметры для частичного обновления профиля пользователя.
        ///
        /// ### Properties:
        ///   - nickname: Новый псевдоним пользователя, если требуется обновление.
        ///  - avatar: Новая ссылка на изображение аватара пользователя, если требуется обновление.
        ///  - contact: Контактная информация пользователя, для востонавления данных и так далее
        @Serializable
        data class Patch(
            val nickname: String?,
            val avatar: URI?,
            val contact: Contact.Parameters.Create?,
        ) : Parametable()
    }

    // MARK: - Responses -
    data object Responses {
        /// Полные данные о пользователе для отображения на странице профиля.
        ///
        /// ### Properties:
        ///   - id: Уникальный идентификатор пользователя в системе.
        ///  - avatar: Ссылка на изображение аватара пользователя, может быть не указана.
        ///  - nickname: Отображаемое имя пользователя.
        ///  - contact: Полная контактная информация, ассоциированная с профилем пользователя.
        ///  - options: Роли пользователя, определенные в системе.
        @Serializable
        data class Full(
            val id: UUID,
            val avatar: URI?,
            val nickname: String,
            val contact: Contact.Responses.Full?,
            val options: UserRoleSet,
            val permissions: MaestriPermissionSet,
        ) : Responsable

        /// Краткие данные о пользователе для отображения на главной странице.
        ///
        /// ### Properties:
        ///  - avatar: Ссылка на изображение аватара пользователя, может быть не указана.
        ///  - nickname: Псевдоним пользователя для представления в пользовательском интерфейсе.
        @Serializable
        data class Partial(
            val avatar: URI? = null,
            val nickname: String,
        ) : Responsable
    }
}

