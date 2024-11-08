package com.maestri.sdk.sources.shared.dto.primitives

import com.maestri.sdk.sources.shared.dto.protocols.Parametable
import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import kotlinx.serialization.Serializable

/// Полные данные об адресе для ответа.
/// Структура включает в себя идентификатор и основные данные об адресе, используемые для ответа в API.
///
/// ### Properties:
///  - address: Полное текстовое описание адреса.
///  - city: Название города, где находится адрес.
///  - country: Название страны, где находится адрес.
///  - latitude: Географическая широта адреса.
///  - longitude: Географическая долгота адреса.
@Serializable
data class Address(
    val address: String,
    val city: String,
    val country: String,
    val latitude: Double,
    val longitude: Double,
) : Parametable(), Responsable
