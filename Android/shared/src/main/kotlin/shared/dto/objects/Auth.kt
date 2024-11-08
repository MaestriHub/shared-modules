package com.maestri.sdk.sources.shared.dto.objects

import com.maestri.sdk.sources.shared.dto.primitives.Token
import com.maestri.sdk.sources.shared.dto.protocols.Parametable
import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import kotlinx.serialization.Serializable

/// Пространство имен `Auth` содержит типы данных для работы с записями на прием.
///
/// В него входят как параметры для запросов (`Parameters`), так и модели ответов (`Responses`),
/// которые используются для сериализации данных, отправляемых и получаемых от API.
object Auth {
    // MARK: - Parameters -
    data object Parameters {
        /// Параметры для аутентификации через Apple.
        /// Структура `AppleToken` содержит данные, полученные от Apple при аутентификации пользователя.
        ///
        /// ### Properties:
        ///   - token: Токен, выданный Apple.
        ///  - firstName: Имя пользователя, полученное от Apple, если доступно.
        ///  - lastName: Фамилия пользователя, полученное от Apple, если доступно.
        ///  - email: Электронная почта пользователя, если доступна.
        ///  - emailVerified: Флаг, указывающий, подтверждён ли email.
        @Serializable
        data class AppleToken(
            val token: String,
            val firstName: String?,
            val lastName: String?,
            val email: String?,
            val emailVerified: Boolean? = false,
        ) : Parametable()

        /// Параметры для аутентификации через Google.
        /// Структура `GoogleToken` содержит данные, полученные от Google при аутентификации пользователя.
        ///
        /// ### Properties:
        ///   - token: Токен, выданный Google.
        ///  - firstName: Имя пользователя, полученное от Google, если доступно.
        ///  - lastName: Фамилия пользователя, полученное от Google, если доступно.
        @Serializable
        data class GoogleToken(
            val token: String,
            val firstName: String?,
            val lastName: String?,
        ) : Parametable()
    }

    // MARK: - Responses -
    data object Responses {
        /// Полный ответ аутентификации.
        /// Структура `Full` предоставляет токен аутентификации и полную информацию о пользователе.
        ///
        /// ### Properties:
        ///   - accessToken: Токен аутентификации.
        ///  - refreshToken: Токен сессии.
        ///  - user: Полная информация о пользователе в формате `User.Responses.Full`.
        @Serializable
        data class Full(
            val accessToken: Token,
            val refreshToken: Token,
            val user: User.Responses.Full,
        ) : Responsable

        /// Частичный ответ аутентификации.
        /// Структура `Partial` предоставляет токен аутентификации без дополнительных данных о пользователе.
        ///
        /// ### Properties:
        ///   - accessToken: Токен аутентификации.
        ///  - refreshToken: Токен сессии.
        @Serializable
        data class Partial(
            val accessToken: Token,
            val refreshToken: Token?,
        ) : Responsable
    }
}
