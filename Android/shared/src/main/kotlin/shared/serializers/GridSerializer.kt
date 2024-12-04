import kotlinx.serialization.KSerializer
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.builtins.PairSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.descriptors.buildClassSerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.decodeFromJsonElement
import kotlinx.serialization.json.encodeToJsonElement
import kotlinx.serialization.json.jsonArray
import shared.dto.enums.SalaryPaymentType
import shared.dto.enums.ServiceCategory
import shared.dto.objects.Service
import java.util.Locale

object ServicePairListSerializer : KSerializer<List<Pair<Service.Responses.Partial, SalaryPaymentType>>> {

    override val descriptor: SerialDescriptor = buildClassSerialDescriptor("ServicePairList") {
        element(
            "pairs",
            ListSerializer(
                PairSerializer(
                    Service.Responses.Partial.serializer(),
                    SalaryPaymentType.serializer()
                )
            ).descriptor
        )
    }

    override fun deserialize(decoder: Decoder): List<Pair<Service.Responses.Partial, SalaryPaymentType>> {
        val jsonInput = decoder.decodeSerializableValue(JsonElement.serializer()).jsonArray
        val pairs = mutableListOf<Pair<Service.Responses.Partial, SalaryPaymentType>>()

        // Проходим по JSON и десериализуем каждую пару
        for (i in jsonInput.indices step 2) {
            val serviceJson = jsonInput[i]
            val paymentTypeJson = jsonInput.getOrNull(i + 1)

            if (serviceJson is JsonObject && paymentTypeJson != null) {
                // Десериализуем объекты
                val service = Json.decodeFromJsonElement<Service.Responses.Partial>(serviceJson)
                val paymentType = Json.decodeFromJsonElement<SalaryPaymentType>(paymentTypeJson)

                // Добавляем пару в список
                pairs.add(Pair(service, paymentType))
            }
        }


        return pairs
    }

    override fun serialize(encoder: Encoder, value: List<Pair<Service.Responses.Partial, SalaryPaymentType>>) {
        val jsonArray = JsonArray(value.flatMap { pair ->
            listOf(
                Json.encodeToJsonElement(pair.first),
                Json.encodeToJsonElement(pair.second)
            )
        })


        // Сериализуем список JSON объектов
        encoder.encodeSerializableValue(JsonElement.serializer(), jsonArray)
    }
}

object ServiceCategorySerializer : KSerializer<ServiceCategory> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("ServiceCategory", PrimitiveKind.STRING)

    override fun serialize(encoder: Encoder, value: ServiceCategory) {
        encoder.encodeString(value.name.lowercase(Locale.getDefault())) // Преобразуем в строку с маленькими буквами
    }

    override fun deserialize(decoder: Decoder): ServiceCategory {
        val value =
            decoder.decodeString().uppercase(Locale.getDefault()) // Преобразуем строку в верхний регистр
        return try {
            ServiceCategory.valueOf(value)
        } catch (e: IllegalArgumentException) {
            // Если не найдено значение, возвращаем значение по умолчанию или выбрасываем ошибку
            ServiceCategory.COSMETOLOGY // Можно выбросить ошибку или вернуть значение по умолчанию
        }
    }
}