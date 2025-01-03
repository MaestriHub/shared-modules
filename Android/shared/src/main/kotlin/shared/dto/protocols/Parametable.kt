package shared.dto.protocols

import io.ktor.util.*
import shared.dto.utils.ParamsEncodeUtils

abstract class Parametable {
    fun toStringValues(): StringValues = StringValues.build {
        ParamsEncodeUtils.encodeToMap(this@Parametable).forEach { (key, value) ->
            append(key, value.toString())
        }
    }
}