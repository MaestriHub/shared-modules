import { ValidateNested } from "class-validator"
import { PaymentPeriod } from "../enums/PaymentPeriod"
import { Price } from "../primitives/Price"

export class Wage {
    @ValidateNested()
    price: Price

    period: PaymentPeriod

    constructor(
        price: Price,
        period: PaymentPeriod
    ) {
        this.price = price
        this.period = period
    }
}