package shared.dto.utils

import io.ktor.util.*
import kotlinx.serialization.json.*

object ParamsEncodeUtils {
    fun Map<String, Any?>.toStringValues() = StringValues.build {
        forEach { append(it.key, it.value.toString()) }
    }

    inline fun <reified T> encodeToMap(obj: T, json: Json = Json): Map<String, Any?> {
        return jsonObjectToMap(json.encodeToJsonElement(obj).jsonObject)
    }

    fun jsonObjectToMap(element: JsonObject): Map<String, Any?> {
        return element.entries.associate {
            it.key to extractValue(it.value)
        }
    }

    private fun extractValue(element: JsonElement): Any? {
        return when (element) {
            is JsonNull -> null
            is JsonPrimitive -> element.content
            is JsonArray -> element.map { extractValue(it) }
            is JsonObject -> jsonObjectToMap(element)
        }
    }
}