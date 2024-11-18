import { SalonType } from "../enums/SalonType"
import { Salon } from "./Salon"

export namespace Search {

    export namespace Parameters {
        
        export class Retrieve {
            value?: string
            salonType?: SalonType
            latitude?: number //double
            longitude?: number
            page?: number
            per?: number
        }
    }

    export namespace Responses {

        export class Suggest {
            value: string

            constructor(
                value: string
            ) {
                this.value = value
            }
        }

        export class Full {
            suggests: Suggest[]
            salons: Salon.Responses.Partial[]

            constructor(
                suggests: Suggest[],
                salons: Salon.Responses.Partial[]
            ) {
                this.suggests = suggests
                this.salons = salons
            }
        }
    }
}