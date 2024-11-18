import { isDecimal, IsDecimal } from "class-validator"

export class Decimal {
    
    @IsDecimal()
    private decimal: string

    constructor(value: string) {
        this.decimal = value
    }

    public toJSON() {
        return this.decimal
    }

    public static fromJSON(decimal: string): Decimal {
        if (!isDecimal(decimal)) {
            throw new Error("Invalid Int")
        }
        return new Decimal(decimal)
    }
}