import { DateInterval } from "../tsPrimitives/DateInterval"
import { Price } from "../primitives/Price"
import { Address } from "../primitives/Address"
import { AppointmentStatus } from "../enums/AppointmentStatus"

export type AppointmentEmployee = Parameters | Responses

type Parameters =  Retrieve | Create | Patch | Approve

type Responses = Full | Partial | Base

interface Retrieve {
    startDate: Date | undefined
    endDate: Date | undefined
    employees: string[] | undefined
    salons: string[] | undefined
    customer: string | undefined
}

interface Create {
    customerId: string
    type: AppointmentType
    time: DateInterval
}

interface Patch {
    time: DateInterval
}

interface Approve {
    appointmentsEmployeeId: string[]
}

interface Full {
    // salon //TODO:
    // customer
    address: Address
    associative: Base[]
}

interface Partial {
    // customer
    associative: Base[]
}

interface Base {
    id: string
    status: AppointmentStatus
    // procedure:
    time: DateInterval
    price: Price
}