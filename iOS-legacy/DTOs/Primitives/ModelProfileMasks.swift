import Foundation

// MARK: - Model Profile Status -

public enum ModelProfileStatus: String, Codable, CaseIterable, Sendable {
    case active
    case suspended
}

// MARK: - Availability Masks -

/// Маска доступности по дням недели
/// Значения: 1 = будни, 2 = выходные, 3 = все дни (1 | 2)
public struct AvailabilityDaysMask: OptionSet, Codable, Sendable {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let weekdays = AvailabilityDaysMask(rawValue: 1 << 0)  // 1
    public static let weekends = AvailabilityDaysMask(rawValue: 1 << 1)   // 2
    public static let all: AvailabilityDaysMask = [.weekdays, .weekends]  // 3
    
    /// Проверяет, что маска содержит валидное значение (1-3)
    public var isValid: Bool {
        rawValue >= 1 && rawValue <= 3
    }
    
    // Codable: кодируем/декодируем как Int
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(Int.self)
        self.init(rawValue: rawValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

/// Маска доступности по времени суток
/// Значения: 1 = утро, 2 = день, 4 = вечер, комбинации: 7 = все (1 | 2 | 4)
public struct AvailabilityTimesMask: OptionSet, Codable, Sendable {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let morning = AvailabilityTimesMask(rawValue: 1 << 0)  // 1
    public static let day = AvailabilityTimesMask(rawValue: 1 << 1)      // 2
    public static let evening = AvailabilityTimesMask(rawValue: 1 << 2) // 4
    public static let all: AvailabilityTimesMask = [.morning, .day, .evening] // 7
    
    /// Проверяет, что маска содержит валидное значение (1-7)
    public var isValid: Bool {
        rawValue >= 1 && rawValue <= 7
    }
    
    // Codable: кодируем/декодируем как Int
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(Int.self)
        self.init(rawValue: rawValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

/// Маска доступности по тегам (64-битная)
public struct AvailabilityTagsMask: OptionSet, Codable, Sendable {
    public let rawValue: Int64
    
    public init(rawValue: Int64) {
        self.rawValue = rawValue
    }
    
    // Codable: кодируем/декодируем как Int64
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(Int64.self)
        self.init(rawValue: rawValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

/// Маска ограничений (64-битная)
public struct RestrictionsMask: OptionSet, Codable, Sendable {
    public let rawValue: Int64
    
    public init(rawValue: Int64) {
        self.rawValue = rawValue
    }
    
    // Codable: кодируем/декодируем как Int64
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(Int64.self)
        self.init(rawValue: rawValue)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

