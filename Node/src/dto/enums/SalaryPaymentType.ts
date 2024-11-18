import { Price } from "../primitives/Price"
import { Int } from "../tsPrimitives/Int"

type Percent = Int
type Value = Price

export enum Types {
    PERCENT = "percent",
    VALUE = "value",
}

export class SalaryPaymentType {
    type: Types
    salary: Value | Percent

    constructor(type: Types, salary: Value | Percent) {
        this.type = type
        this.salary = salary
    }

    //TODO: проверить
    //TODO: проверить
    toJSON() {
        let key: string
        switch (this.type) {
            case Types.PERCENT:
                key = "percent"
            case Types.VALUE:
                key = "value"
        }

        return {
            [this.type]: {
                [key]: this.salary
            }
        }
    }

    //TODO: проверить
    static fromJSON(json: any): SalaryPaymentType {
        const type = Object.keys(json).find(key => Object.values(Types).find(value => value === key));
        if (!type) {
            throw new Error('Invalid JSON: no type found');
        }
        const salary = json[type].salary;

        return new SalaryPaymentType(type as Types, salary);
    }
}