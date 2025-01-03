package shared.dto.enums

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.jsonObject
import shared.dto.protocols.Responsable

@Serializable(SystemType.Serializer::class)
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

    internal object Serializer :
        JsonContentPolymorphicSerializer<SystemType>(SystemType::class) {
        override fun selectDeserializer(element: JsonElement): DeserializationStrategy<SystemType> {
            val keys = element.jsonObject.keys
            return when {
                "ios" in keys -> Ios.serializer()
                "android" in keys -> Android.serializer()
                "chrome" in keys -> Chrome.serializer()
                "edge" in keys -> Edge.serializer()
                "firefox" in keys -> Firefox.serializer()
                "opera" in keys -> Opera.serializer()
                "safari" in keys -> Safari.serializer()
                else -> throw SerializationException("Unknown pattern type")
            }
        }
    }
}