import { PaymentType } from "../../enums/PaymentType"

// TODO: 
// FLOW EXAMPLE
//import * as Cashbox from "./Cashbox";
//
// const cashbox: Cashbox.Create = {
//     salonId: "",
//     paymentType: PaymentType.BANK_TRANSFER,
// }

// const createDTO: Create = cashbox

export type Cashbox = Parameters | Responses

type Parameters = Create | Retrieve

type Responses = Full

export interface Create {
    salonId: string // TODO: UUID представлено как строка??
    paymentType: PaymentType
}

export interface Retrieve {
    paymentType: PaymentType | undefined
    startDate: Date | undefined
    endDate: Date | undefined
}

export interface Full {
    id: string // TODO: UUID представлено как строка??
    createDate: Date
    paymentType: PaymentType
}