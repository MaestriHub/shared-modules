import { DateInterval } from "../tsPrimitives/DateInterval"
import { Price } from "../primitives/Price"
import { Address } from "../primitives/Address"
import { AppointmentStatus } from "../enums/AppointmentStatus"
import { AppointmentType } from "../enums/AppointmentType"

export namespace AppointmentEmployee {

    export namespace Parameters {
        
        export class Retrieve {
            startDate?: Date
            endDate?: Date
            employees?: string[]
            salons?: string[]
            customer?: string

            constructor(
                startDate?: Date,
                endDate?: Date,
                employees?: string[],
                salons?: string[],
                customer?: string
            ) {
                this.startDate = startDate
                this.endDate = endDate
                this.employees = employees
                this.salons = salons
                this.customer = customer
            }
        }

        export class Create {
            customerId: string
            type: AppointmentType
            time: DateInterval

            constructor(
                customerId: string,
                type: AppointmentType,
                time: DateInterval
            ) {
                this.customerId = customerId
                this.type = type
                this.time = time
            }
        }

        export class Patch {
            time: DateInterval

            constructor(
                time: DateInterval
            ) {
                this.time = time
            }
        }

        export class Approve {
            appointmentsEmployeeId: string[]

            constructor(
                appointmentsEmployeeId: string[]
            ) {
                this.appointmentsEmployeeId = appointmentsEmployeeId
            }
        }
    }

    export namespace Responses {

        export class Full {
            // salon //TODO:
            // customer
            address: Address
            associative: Base[]

            constructor(
                address: Address,
                associative: Base[]
            ) {
                this.address = address
                this.associative = associative
            }
        }

        export class Partial {
            // customer
            associative: Base[]

            constructor(
                associative: Base[]
            ) {
                this.associative = associative
            }
        }

        export class Base {
            id: string
            status: AppointmentStatus
            // procedure:
            time: DateInterval
            price: Price

            constructor(
                id: string,
                status: AppointmentStatus,
                // procedure:
                time: DateInterval,
                price: Price
            ) {
                this.id = id
                this.status = status
                this.time = time
                this.price = price
            }
        }
    }
}