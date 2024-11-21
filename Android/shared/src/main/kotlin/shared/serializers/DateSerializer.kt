package com.maestri.sdk.sources.shared.serializers

import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerializationException
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import java.text.SimpleDateFormat
import java.util.*

object DateISOSerializer : KSerializer<Date> {
    private val dateFormat = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssX")
    override val descriptor: SerialDescriptor =
        PrimitiveSerialDescriptor("Date", PrimitiveKind.STRING)

    override fun serialize(encoder: Encoder, value: Date) {
        encoder.encodeString(dateFormat.format(value))
    }

    override fun deserialize(decoder: Decoder): Date {
        return dateFormat.parse(decoder.decodeString())
            ?: throw SerializationException("Failed to parse date")
    }
}

object DateUNIXSerializer : KSerializer<Date> {
    override val descriptor: SerialDescriptor =
        PrimitiveSerialDescriptor("UnixTimestamp", PrimitiveKind.LONG)

    override fun serialize(encoder: Encoder, value: Date) {
        encoder.encodeLong(value.time / 1000) // В секунды
    }

    override fun deserialize(decoder: Decoder): Date {
        return Date(decoder.decodeLong() * 1000)
    }
}
