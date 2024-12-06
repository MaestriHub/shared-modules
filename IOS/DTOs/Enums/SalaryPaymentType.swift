//
//  SalaryPaymentType.swift
//  Created by Алексей on 05.08.2024.
//

import Foundation

public enum SalaryPaymentType: Codable, Hashable {
    case percent(Int)
    case value(Price)
    
    enum CodingKeys: String, CodingKey {
        case percent = "percent"
        case value = "value"
    }

        // Декодирование
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let value = try? container.decode(Int.self, forKey: .percent) {
            self = .percent(value)
        } else if let value = try? container.decode(Price.self, forKey: .value) {
            self = .value(value)
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.percent,
                in: container,
                debugDescription: "Unable to decode Foo enum"
            )
        }
    }

    // Кодирование
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .percent(let value):
            try container.encode(value, forKey: .percent)
        case .value(let value):
            try container.encode(value, forKey: .value)
        }
    }

}
