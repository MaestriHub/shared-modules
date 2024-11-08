@file:UseSerializers(UUIDSerializer::class)

package com.maestri.sdk.sources.shared.dto.objects


import com.maestri.sdk.sources.shared.dto.protocols.`Parametable ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.UUID

/// Пространство имен `Device` содержит типы данных для работы с информацией о клиентах.
///
/// В него входят  модели ответов (`Responses`),
/// используемые для обмена данными между клиентом и сервером в контексте клиентских данных.
object Device {
    // MARK: - Parameters -
    data object Parameters {

        @Serializable
        /* data */ class Create : `Parametable ✅`()

        @Serializable
        data class RegisterPush(
            val token: Token,
        ) : `Parametable ✅`() {
            @Serializable
            sealed class Token {
                @Serializable
                @SerialName("apple")
                data class Apple(
                    val token: String,
                ) : Token()

                @Serializable
                @SerialName("fcm")
                data class Fcm(
                    val token: String,
                ) : Token()
            }
        }
    }

    // MARK: - Responses -
    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
        ) : `Responsable ✅`
    }
}


