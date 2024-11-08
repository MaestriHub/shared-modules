@file:UseSerializers(URISerializer::class)

package com.maestri.sdk.sources.shared.dto.objects

import com.maestri.sdk.sources.shared.dto.protocols.Parametable
import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.URISerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.net.URI

/// Пространство имен `Professional` содержит типы данных для работы с информацией о клиентах.
///
/// В него входят параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обмена данными между клиентом и сервером в контексте клиентских данных.
object Professional {
    //MARK: - Parameters -
    data object Parameters {
        @Serializable
        /* data */ class Create : Parametable()
    }

    //MARK: - Responses -
    data object Responses {
        @Serializable
        data class Partial(
            val avatar: URI?,
            val nickname: String,
        ) : Responsable
    }
}
