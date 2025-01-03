import { ValidateNested } from "class-validator"
import { Price } from "../primitives/Price"
import { Int } from "../tsPrimitives/Int"
import { UUID } from "crypto"
import { IsoDate } from "../tsPrimitives/IsoDate"

export namespace Statistic {

    export namespace Parameters {

        export class AppointmentsQuery {
            startDate: IsoDate
            endDate: IsoDate

            @ValidateNested()
            employees?: UUID[]
            
            @ValidateNested()
            salons?: UUID[]

            constructor(
                startDate: IsoDate,
                endDate: IsoDate,
                employees?: UUID[],
                salons?: UUID[]
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
            @ValidateNested()
            price: Price

            @ValidateNested()
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