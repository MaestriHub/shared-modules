import { ValidateNested } from "class-validator"
import { Price } from "../primitives/Price"
import { Int } from "../tsPrimitives/Int"
import { UUID } from "../tsPrimitives/UUID"

export namespace Complex {

    export namespace Parameters {
        
        export class Retrieve {
            @ValidateNested()
            salons?: UUID[]

            @ValidateNested()
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
            procedureIds: UUID[]

            constructor(
                price: Price,
                duration: Int,
                description?: string,
                alias?: string,
                procedureIds: UUID[] = []
            ) {
                this.price = price
                this.duration = duration
                this.description = description
                this.alias = alias
                this.procedureIds = procedureIds
            }
        }

        export class Patch {
            @ValidateNested()
            price: Price

            @ValidateNested()
            duration: Int

            description?: string
            alias?: string

            @ValidateNested()
            procedureIds: UUID[]

            constructor(
                price: Price,
                duration: Int,
                description?: string,
                alias?: string,
                procedureIds: UUID[] = []
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
            @ValidateNested()
            id: UUID

            @ValidateNested()
            price: Price

            @ValidateNested()
            duration: Int

            description?: string
            alias?: string
            //procedureIds: string[]

            constructor(
                id: UUID,
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
            @ValidateNested()
            id: UUID
            
            @ValidateNested()
            price: Price

            @ValidateNested()
            duration: Int
            
            description?: string
            alias?: string
            //procedureIds: string[]

            constructor(
                id: UUID,
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