@file:UseSerializers(UUIDSerializer::class)

package shared.dto.objects

import com.maestri.sdk.sources.shared.dto.objects.`Procedure ✅`
import com.maestri.sdk.sources.shared.dto.primitives.`Price ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Parametable ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.*

// Complex - Сущность которая объединяет несколько процедур
object `Complex ✅` {
    // MARK: - Parameters -
    data object Parameters {
        /// ### Properties:
        ///  - salons: Салоны для фильтрации
        ///  - employees: Работники для фильтрации
        @Serializable
        data class Retrieve(
            val salons: List<UUID>? = null,
            val employees: List<UUID>? = null,
        ) : `Parametable ✅`()

        /// ### Properties:
        ///  - price: Стоимость
        ///  - duration: Длительность
        ///  - description: Описание
        ///  - alias: Название
        ///  - procedureIds: Процедуры которые содержатся в комплексе
        @Serializable
        data class Create(
            val price: `Price ✅`,
            val duration: Int,
            val description: String?,
            val alias: String?,
            val procedureIds: List<UUID>,
        ) : `Parametable ✅`()

        /// ### Properties:
        ///  - price: Стоимость
        ///  - duration: Длительность
        ///  - description: Описание
        ///  - alias: Название
        ///  - procedureIds: Процедуры которые содержатся в комплексе
        @Serializable
        data class Patch(
            val price: `Price ✅`,
            val duration: Int,
            val description: String?,
            val alias: String?,
            val procedureIds: List<UUID>,
        ) : `Parametable ✅`()
    }

    // MARK: - Responses -
    data object Responses {
        /// ### Properties:
        ///  - id: айдишник
        ///  - price: Стоимость
        ///  - duration: Длительность
        ///  - description: Описание
        ///  - alias: Название
        ///  - procedures: Процедуры которые содержатся в комплексе
        @Serializable
        data class Full(
            val id: UUID,
            val price: `Price ✅`,
            val duration: Int,
            val description: String?,
            val alias: String?,
            val procedures: List<`Procedure ✅`.Responses.Partial>
        ) : `Responsable ✅`

        /// ### Properties:
        ///  - id: айдишник
        ///  - price: Стоимость
        ///  - duration: Длительность
        ///  - description: Описание
        ///  - alias: Название
        ///  - procedures: Процедуры которые содержатся в комплексе
        @Serializable
        data class Partial(
            val id: UUID,
            val price: `Price ✅`,
            val duration: Int,
            val description: String?,
            val alias: String?,
            val procedures: List<`Procedure ✅`.Responses.Partial>
        ) : `Responsable ✅`
    }
}
