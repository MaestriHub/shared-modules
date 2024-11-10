package shared.dto.protocols

import shared.dto.utils.ParamsEncodeUtils
import io.ktor.util.StringValues

abstract class Parametable {
    fun toStringValues(): StringValues = StringValues.build {
        ParamsEncodeUtils.encodeToMap(this@Parametable).forEach { (key, value) ->
            append(key, value.toString())
        }
    }
}