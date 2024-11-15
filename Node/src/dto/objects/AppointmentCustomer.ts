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
        }

        export class Create {
            type: AppointmentType
            time: DateInterval
        }

        export class Patch {
            time: DateInterval
        }
    }

    export namespace Responses {

        export class Full {
            id: string
            status: AppointmentStatus
            // salon: TODO:
            // procedures:
            time: DateInterval
            price: Price
            address: Address
        }

        export class Partial {
            id: string
            status: AppointmentStatus
            // procedures:
            time: DateInterval
            price: Price
        }
    }
}