import Foundation

public extension DateFormatter {
    static var iso8601: ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }
}

public extension JSONDecoder {
    static let `default`: JSONDecoder = JSONDecoder
        .with(.roundedDate(.millisecondsAndSeconds))
}

public extension JSONEncoder {
    static let `default`: JSONEncoder = JSONEncoder
        .with(.roundedDate(.millisecondsAndSeconds))
}

public extension JSONDecoder {
    enum Param {
        case roundedDate(Date.RoundingPrecision)
        case custom((JSONDecoder) -> Void)
        
        func apply(decoder: JSONDecoder) -> Void {
            switch self {
            case .roundedDate(let precision):
                decoder.withRoundedDate(precision)
            case .custom(let functor):
                functor(decoder)
            }
        }
    }
}
    
public extension JSONDecoder {
    static func with(_ params: Param...) -> JSONDecoder {
        params.reduce(into: JSONDecoder()) { $1.apply(decoder: $0) }
    }
    
    func withRoundedDate(_ precision: Date.RoundingPrecision) -> Void {
        dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            guard let date = DateFormatter.iso8601.date(from: dateString) else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Invalid ISO8601 date format with fractional seconds"
                )
            }
            
            return date.rounded(precision)
        }
    }
}

public extension JSONEncoder {
    enum Param {
        case roundedDate(Date.RoundingPrecision)
        case custom((JSONEncoder) -> Void)
        
        func apply(encoder: JSONEncoder) -> Void {
            switch self {
            case .roundedDate(let precision):
                encoder.withRoundedDate(precision)
            case .custom(let functor):
                functor(encoder)
            }
        }
    }
}
    
public extension JSONEncoder {
    static func with(_ params: Param...) -> JSONEncoder {
        params.reduce(into: JSONEncoder()) { $1.apply(encoder: $0) }
    }
    
    func withRoundedDate(_ precision: Date.RoundingPrecision) -> Void {
        dateEncodingStrategy = .custom { date, encoder in
            let formattedDate = date.rounded(precision)
            
            let dateString = DateFormatter.iso8601.string(from: formattedDate)
            var container = encoder.singleValueContainer()
            try container.encode(dateString)
        }
    }
}
