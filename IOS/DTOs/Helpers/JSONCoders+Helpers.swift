import Foundation

public extension DateFormatter {
    static var iso8601: ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }
}

public extension JSONDecoder {
    static func build(_ params: (JSONDecoder) -> JSONDecoder...) -> JSONDecoder {
        var decoder = JSONDecoder()
        for p in params {
            decoder = p(decoder)
        }
        return decoder
    }
}

public extension JSONDecoder {
    static func withRoundedMilliseconds(_ d: JSONDecoder) -> JSONDecoder {
        return millisecondsStrategy(d, round: true)
    }
    
    static func withMilliseconds(_ d: JSONDecoder) -> JSONDecoder {
        return millisecondsStrategy(d, round: false)
    }
    
    static func millisecondsStrategy(_ d: JSONDecoder, round: Bool) -> JSONDecoder {
        d.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            guard var date = DateFormatter.iso8601.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format")
            }
            
            if round {
                date = date.roundMilliseconds()
            }
            
            return date
        }
        
        return d
    }
}

public extension JSONEncoder {
    static func build(_ params: (JSONEncoder) -> JSONEncoder...) -> JSONEncoder {
        var encoder = JSONEncoder()
        for p in params {
            encoder = p(encoder)
        }
        return encoder
    }
}

public extension JSONEncoder {
    static func withRoundedMilliseconds(_ e: JSONEncoder) -> JSONEncoder {
        return millisecondsStrategy(e, round: true)
    }
    
    static func withMilliseconds(_ e: JSONEncoder) -> JSONEncoder {
        return millisecondsStrategy(e, round: false)
    }
    
    static func millisecondsStrategy(_ e: JSONEncoder, round: Bool) -> JSONEncoder {
        e.dateEncodingStrategy = .custom { date, encoder in
            var formattedDate = date
            
            if round {
                formattedDate = date.roundMilliseconds()
            }
            
            let dateString = DateFormatter.iso8601.string(from: formattedDate)
            var container = encoder.singleValueContainer()
            try container.encode(dateString)
        }
        
        return e
    }
}
