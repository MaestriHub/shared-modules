@file:UseSerializers(UUIDSerializer::class)

package com.maestri.sdk.sources.shared.dto.objects

import com.maestri.sdk.sources.shared.dto.optionSet.`PermissionSet ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Parametable ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.objects.`Salary ✅`
import java.util.UUID

/// Пространство имен `Position` содержит типы данных для работы с информацией о сотрудниках.
///
/// Включает в себя параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// которые применяются для обмена данными о сотрудниках между клиентскими приложениями и сервером.
object `Position ✅` {
    //MARK: - Parameters -
    data object Parameters {
        @Serializable
        data class Create(
            val title: String,
            val permissions: `PermissionSet ✅`,
            val salary: `Salary ✅`.Parameters.Rules.Create,
        ) : `Parametable ✅`()

        @Serializable
        data class Patch(
            val title: String?,
            val permissions: `PermissionSet ✅`?,
            val salary: `Salary ✅`.Parameters.Rules.Create,
        ) : `Parametable ✅`()
    }

    //MARK: - Responses -
    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
            val title: String,
            val permissions: `PermissionSet ✅`,
            val salary: `Salary ✅`.Responses.Rules.Full,
        ) : `Responsable ✅`

        @Serializable
        data class Partial(
            val id: UUID,
            val title: String,
        ) : `Responsable ✅`
    }
}