import { DateInterval } from "../tsPrimitives/DateInterval"
import { Price } from "../primitives/Price"
import { Address } from "../primitives/Address"
import { AppointmentStatus } from "../enums/AppointmentStatus"
import { AppointmentType } from "../enums/AppointmentType"
import { UUID } from "../tsPrimitives/UUID"
import { ValidateNested } from "class-validator"
import { Salon } from "./Salon"
import { Customer } from "./Customer"
import { Procedure } from "./Procedure"

export namespace AppointmentEmployee {

    export namespace Parameters {
        
        export class Retrieve {
            startDate?: Date
            endDate?: Date

            @ValidateNested()
            employees?: UUID[]

            @ValidateNested()
            salons?: UUID[]

            @ValidateNested()
            customer?: UUID

            constructor(
                startDate?: Date,
                endDate?: Date,
                employees?: UUID[],
                salons?: UUID[],
                customer?: UUID
            ) {
                this.startDate = startDate
                this.endDate = endDate
                this.employees = employees
                this.salons = salons
                this.customer = customer
            }
        }

        export class Create {
            @ValidateNested()
            customerId: UUID

            type: AppointmentType

            @ValidateNested()
            time: DateInterval

            constructor(
                customerId: UUID,
                type: AppointmentType,
                time: DateInterval
            ) {
                this.customerId = customerId
                this.type = type
                this.time = time
            }
        }

        export class Patch {
            @ValidateNested()
            time: DateInterval

            constructor(
                time: DateInterval
            ) {
                this.time = time
            }
        }

        export class Approve {
            @ValidateNested()
            appointmentsEmployeeId: UUID[]

            constructor(
                appointmentsEmployeeId: UUID[]
            ) {
                this.appointmentsEmployeeId = appointmentsEmployeeId
            }
        }
    }

    export namespace Responses {

        export class Full {
            @ValidateNested()
            salon: Salon.Responses.Partial

            @ValidateNested()
            customer: Customer.Responses.Partial

            @ValidateNested()
            address: Address
            
            @ValidateNested()
            associative: Base[]

            constructor(
                salon: Salon.Responses.Partial,
                customer: Customer.Responses.Partial,
                address: Address,
                associative: Base[]
            ) {
                this.salon = salon
                this.customer = customer
                this.address = address
                this.associative = associative
            }
        }

        export class Partial {
            @ValidateNested()
            customer: Customer.Responses.Partial

            @ValidateNested()
            associative: Base[]

            constructor(
                customer: Customer.Responses.Partial,
                associative: Base[]
            ) {
                this.customer = customer
                this.associative = associative
            }
        }

        export class Base {
            @ValidateNested()
            id: UUID
            
            status: AppointmentStatus
            
            @ValidateNested()
            procedure: Procedure.Responses.Partial
            
            @ValidateNested()
            time: DateInterval

            @ValidateNested()
            price: Price

            constructor(
                id: UUID,
                status: AppointmentStatus,
                procedure: Procedure.Responses.Partial,
                time: DateInterval,
                price: Price
            ) {
                this.id = id
                this.status = status
                this.procedure = procedure
                this.time = time
                this.price = price
            }
        }
    }
}