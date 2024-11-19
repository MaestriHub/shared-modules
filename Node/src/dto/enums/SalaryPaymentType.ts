import { ValidateNested } from "class-validator";
import { Int } from "../tsPrimitives/Int";
import { Price } from "../primitives/Price";

export class SalaryPaymentType {
    type: SalaryPaymentType.Types

    constructor(type: SalaryPaymentType.Types) {
        this.type = type
    }

    toJSON() {
        switch (true) {
        case this.type instanceof SalaryPaymentType.Percent:
            return {
                percent: this.type
            }
        case this.type instanceof SalaryPaymentType.Value:
            return {
                value: this.type
            }
        }
    }

    static fromJSON(json: any): SalaryPaymentType {
        if (json.percent) {
            return new SalaryPaymentType(json.percent);
        } else if (json.value) {
            return new SalaryPaymentType(json.value);
        } else {
            throw new Error("Unknown Schedule pattern type");
        }
    }
}

export namespace SalaryPaymentType {

    export type Types = SalaryPaymentType.Percent | 
                        SalaryPaymentType.Value

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