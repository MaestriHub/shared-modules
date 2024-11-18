import { IsCurrency, isCurrency, IsDecimal, ValidateNested } from "class-validator"
import { Decimal } from "../tsPrimitives/Decimal"

export class Price {
    @ValidateNested()
    amount: Decimal

    @IsCurrency()
    currency: string

    constructor(
        amount: Decimal, 
        currency: string
    ) {
        this.amount = amount
        this.currency = currency
    }
}