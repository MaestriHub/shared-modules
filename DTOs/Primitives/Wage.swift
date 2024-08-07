//
//  Wage.swift
//  Created by Алексей on 05.08.2024.
//

import Foundation

public struct Wage: Codable, Hashable {
    public var price: Price
    public var period: PaymentPeriod

    public init(
        price: Price,
        period: PaymentPeriod
    ) {
        self.price = price
        self.period = period
    }
}
