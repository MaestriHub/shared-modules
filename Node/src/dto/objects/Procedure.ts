import { ValidateNested } from "class-validator"
import { Price } from "../primitives/Price"
import { Int } from "../tsPrimitives/Int"
import { UUID } from "../tsPrimitives/UUID"

export namespace Procedure {
    
    export namespace Parameters {
        
        export class Retrieve {
            salons?: UUID[]
            employees?: UUID[]

            constructor(
                salons?: UUID[],
                employees?: UUID[]
            ) {
                this.salons = salons
                this.employees = employees
            }
        }

        export class Create {
            @ValidateNested()
            price: Price

            @ValidateNested()
            duration: Int
            description?: string
            alias?: string

            @ValidateNested()
            serviceId: UUID

            @ValidateNested()
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
            @ValidateNested()
            price?: Price

            @ValidateNested()
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
            @ValidateNested()
            id: UUID

            @ValidateNested()
            price: Price

            @ValidateNested()
            duration: Int

            description?: string
            alias?: string
            //service: 
            //master: 
        }

        export class Partial {
            @ValidateNested()
            id: UUID

            @ValidateNested()
            price: Price

            @ValidateNested()
            duration: Int

            
            description?: string
            alias?: string
            //service:
        }
    }
}