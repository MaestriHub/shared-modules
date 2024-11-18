import { Price } from "../primitives/Price"
import { Int } from "../tsPrimitives/Int"
import { UUID } from "../tsPrimitives/UUID"

export namespace Procedure {
    
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
            serviceId: UUID
            employeeId: UUID

            constructor(
                price: Price,
                duration: Int,
                serviceId: UUID,
                employeeId: UUID,
                description?: string,
                alias?: string,
            ) {
                this.price = price
                this.duration = duration
                this.description = description
                this.alias = alias
            }
        }

        export class Patch {
            price?: Price
            duration?: Int
            description?: string
            alias?: string

            constructor(
                price?: Price,
                duration?: Int,
                description?: string,
                alias?: string
            ) {
                this.price = price
                this.duration = duration
                this.description = description
                this.alias = alias
            }
        }
    }
    
    export namespace Responses {
    
        export class Full {
            id: UUID
            price: Price
            duration: Int
            description?: string
            alias?: string
            //service: 
            //master: 
        }

        export class Partial {
            id: UUID
            price: Price
            duration: Int
            description?: string
            alias?: string
            //service:
        }
    }
}