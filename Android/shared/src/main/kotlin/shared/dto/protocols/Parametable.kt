package com.maestri.sdk.sources.shared.dto.protocols

import com.maestri.sdk.sources.shared.dto.utils.ParamsEncodeUtils
import io.ktor.util.StringValues


/// Протокол, обозначающий, что тип может быть закодирован и декодирован для передачи данных.
///
/// Этот протокол обеспечивает соответствие типа требованиям кодирования и декодирования,
/// необходимым для сериализации данных в формате JSON, что позволяет использовать его
/// в качестве контента для запросов и ответов сервера Vapor.
///
/// Используется в запросах и ответах API, `Responsable` подразумевает, что тип может быть
/// преобразован из JSON и обратно, что делает его удобным для работы с сетевыми операциями.
/// Поддерживая оба протокола `Decodable` и `Encodable`, `Responsable` обеспечивает,
/// что любой соответствующий тип может быть легко сериализован и десериализован
/// для коммуникации между клиентом и сервером.
///
/// В контексте сервера Vapor, типы, соответствующие `Responsable`, могут использоваться
/// для определения входящего и исходящего содержимого, упрощая тем самым маршрутизацию и
/// обработку данных. Они автоматически обрабатываются Vapor для преобразования между
/// представлением модели данных в Swift и соответствующим представлением в HTTP теле запроса или ответа.
///
/// Примеры использования включают определение моделей запросов для получения данных от клиентов,
/// а также моделей ответов для отправки данных обратно клиентам.
abstract class Parametable {
    fun toStringValues(): StringValues = StringValues.build {
        ParamsEncodeUtils.encodeToMap(this@Parametable).forEach { (key, value) ->
            append(key, value.toString())
        }
    }
}

/// Пример интеграции:
/// ```
///     import Vapor
///
///     // Это расширение должно быть выполнено в коде, который импортирует как Vapor, так и ваш модуль, где объявлен Responsable.
///     extension Responsable where Self: Content {}
///
///     // Или если вы хотите явно сказать, что каждый Responsable это Content.
///     extension Responsable where Self: Codable {
///         func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
///             return request.eventLoop.makeSucceededFuture(().encodeResponse(status: .ok, headers: .init(), for: request))
///         }
///     }
/// ```
