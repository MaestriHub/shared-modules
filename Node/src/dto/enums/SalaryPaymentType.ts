import { ValidateNested } from "class-validator";
import { Int } from "../tsPrimitives/Int";
import { Price } from "../primitives/Price";

export type SalaryPaymentType = SalaryPaymentType.Percent | 
                                SalaryPaymentType.Value

export namespace SalaryPaymentType {

    export class Percent {
        @ValidateNested()
        percent: Int

        constructor(percent: Int) {
            this.percent = percent
        }
    }

    export class Value {
        @ValidateNested()
        value: Price

        constructor(value: Price) {
            this.value = value
        }
    }
}