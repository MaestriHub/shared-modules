import { Price } from "../primitives/Price"
import { Int } from "../tsPrimitives/Int"

export namespace Static {

    export namespace Parameters {

        export class AppointmentsQuery {
            startDate: Date
            endDate: Date
            employees?: string[]
            salons?: string[]

            constructor(
                startDate: Date,
                endDate: Date,
                employees?: string[],
                salons?: string[]
            ) {
                this.startDate = startDate
                this.endDate = endDate
                this.employees = employees
                this.salons = salons
            }
        }
    }

    export namespace Responses {

        export class Appointments {
            price: Price
            count: Int

            constructor(
                price: Price, 
                count: Int
            ) {
                this.price = price
                this.count = count
            }
        }
    }
}