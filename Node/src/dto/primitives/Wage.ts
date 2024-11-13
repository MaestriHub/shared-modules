import { PaymentPeriod } from "../enums/PaymentPeriod"
import { Price } from "../primitives/Price"

export interface Wage {
    price: Price,
    period: PaymentPeriod,
}