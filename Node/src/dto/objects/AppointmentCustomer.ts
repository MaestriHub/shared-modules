import { DateInterval } from "../tsPrimitives/DateInterval"
import { Price } from "../primitives/Price"
import { Address } from "../primitives/Address"
import { AppointmentStatus } from "../enums/AppointmentStatus"

export type AppointmentCustomer = Parameters | Responses

type Parameters =  Retrieve | Create | Patch

type Responses = Full | Partial

interface Retrieve {
    startDate: Date | undefined
    endDate: Date | undefined
    employees: string[] | undefined
    salons: string[] | undefined
}

interface Create {
    type: AppointmentType
    time: DateInterval
}

interface Patch {
    time: DateInterval
}

interface Full {
    id: string
    status: AppointmentStatus
    // salon: TODO:
    // procedures:
    time: DateInterval
    price: Price
    address: Address
}

interface Partial {
    id: string
    status: AppointmentStatus
    // procedures:
    time: DateInterval
    price: Price
}