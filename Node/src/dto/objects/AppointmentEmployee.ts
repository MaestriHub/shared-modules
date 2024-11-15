import { DateInterval } from "../tsPrimitives/DateInterval"
import { Price } from "../primitives/Price"
import { Address } from "../primitives/Address"
import { AppointmentStatus } from "../enums/AppointmentStatus"
import { AppointmentType } from "../enums/AppointmentType"

export namespace AppointmentEmployee {

    export namespace Parameters {
        
        export class Retrieve {
            startDate: Date | undefined
            endDate: Date | undefined
            employees: string[] | undefined
            salons: string[] | undefined
            customer: string | undefined
        }

        export class Create {
            customerId: string
            type: AppointmentType
            time: DateInterval
        }

        export class Patch {
            time: DateInterval
        }

        export class Approve {
            appointmentsEmployeeId: string[]
        }
    }

    export namespace Responses {

        export class Full {
            // salon //TODO:
            // customer
            address: Address
            associative: Base[]
        }

        export class Partial {
            // customer
            associative: Base[]
        }

        export class Base {
            id: string
            status: AppointmentStatus
            // procedure:
            time: DateInterval
            price: Price
        }
    }
}