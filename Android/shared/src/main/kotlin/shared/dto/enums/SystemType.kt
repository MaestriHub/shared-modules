package shared.dto.enums

import kotlinx.serialization.Serializable
import shared.dto.protocols.Responsable

sealed class SystemType : Responsable {
    @Serializable
    data class Ios(
        val version: String,
    ) : SystemType()

    @Serializable
    data class Android(
        val version: String,
    ) : SystemType()

    @Serializable
    data class Chrome(
        val version: String,
    ) : SystemType()

    @Serializable
    data class Edge(
        val version: String,
    ) : SystemType()

    @Serializable
    data class Firefox(
        val version: String,
    ) : SystemType()

    @Serializable
    data class Opera(
        val version: String,
    ) : SystemType()

    @Serializable
    data class Safari(
        val version: String,
    ) : SystemType()
}