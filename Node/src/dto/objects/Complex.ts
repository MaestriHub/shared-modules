import { Price } from "../primitives/Price"
import { Int } from "../tsPrimitives/Int"

export namespace Complex {

    export namespace Parameters {
        
        export class Retrieve {
            salons?: string[]
            employees?: string[]

            constructor(
                salons?: string[], 
                employees?: string[]
            ) {
                this.salons = salons
                this.employees = employees
            }
        }

        export class Create {
            price: Price
            duration: Int
            description?: string
            alias?: string
            procedureIds: string[]

            constructor(
                price: Price,
                duration: Int,
                description?: string,
                alias?: string,
                procedureIds: string[] = []
            ) {
                this.price = price
                this.duration = duration
                this.description = description
                this.alias = alias
                this.procedureIds = procedureIds
            }
        }

        export class Patch {
            price: Price
            duration: Int
            description?: string
            alias?: string
            procedureIds: string[]

            constructor(
                price: Price,
                duration: Int,
                description?: string,
                alias?: string,
                procedureIds: string[] = []
            ) {
                this.price = price
                this.duration = duration
                this.description = description
                this.alias = alias
                this.procedureIds = procedureIds
            }
        }
    }

    export namespace Responses {
        
        export class Full {
            id: string
            price: Price
            duration: Int
            description?: string
            alias?: string
            //procedureIds: string[]

            constructor(
                id: string,
                price: Price,
                duration: Int,
                description?: string,
                alias?: string,
                //procedureIds: string[] = []
            ) {
                this.id = id
                this.price = price
                this.duration = duration
                this.description = description
                this.alias = alias
            }
        }

        export class Partial {
            id: string
            price: Price
            duration: Int
            description?: string
            alias?: string
            //procedureIds: string[]

            constructor(
                id: string,
                price: Price,
                duration: Int,
                description?: string,
                alias?: string,
                //procedureIds: string[] = []
            ) {
                this.id = id
                this.price = price
                this.duration = duration
                this.description = description
                this.alias = alias
            }
        }
    }
}