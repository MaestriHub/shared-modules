import { PaymentType } from "../../enums/PaymentType"
import { Price } from "../../primitives/Price"

export type Operation = Parameters | Responses

type Parameters = Create | Retrieve

type Responses = Full

export interface Create {
    price: Price
    salonId: string // TODO: UUID представлено как строка??
    paymentType: PaymentType
    appointment: AppointmentOperation | undefined
    salary: SalaryOperation | undefined
    other: OtherOperation | undefined
}

export interface Retrieve {
    paymentType: PaymentType | undefined
    startDate: Date | undefined
    endDate: Date | undefined
    cashboxIds: string[]
}

export interface Full {
    id: string // TODO: UUID представлено как строка??
    createDate: Date
    price: Price
    paymentType: PaymentType
}