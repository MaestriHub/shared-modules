import { Price } from "../primitives/Price"

type SalaryPaymentType = Link | Value

interface Percent {
    percent: Int
}

interface Value {
    value: Price
} 