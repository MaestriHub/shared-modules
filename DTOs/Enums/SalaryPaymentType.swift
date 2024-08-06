//
//  SalaryPaymentType.swift
//  Created by Алексей on 05.08.2024.
//

import Foundation

public enum SalaryPaymentType: Codable, Hashable {
    case percent(percent: Int)
    case value(value: Price)
}
