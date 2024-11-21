import { ValidateNested } from "class-validator"
import { Price } from "../primitives/Price"
import { Int } from "../tsPrimitives/Int"
import { UUID } from "../tsPrimitives/UUID"
import { Procedure } from "./Procedure"

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
            description?: string
            alias?: string

            @ValidateNested()
            price: Price

            @ValidateNested()
            duration: Int

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
            description?: string
            alias?: string

            @ValidateNested()
            price: Price

            @ValidateNested()
            duration: Int

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
            description?: string
            alias?: string

            @ValidateNested()
            id: UUID

            @ValidateNested()
            price: Price

            @ValidateNested()
            duration: Int
            
            @ValidateNested()
            procedures: Procedure.Responses.Partial[]

            constructor(
                id: UUID,
                price: Price,
                duration: Int,
                description?: string,
                alias?: string,
                procedures: Procedure.Responses.Partial[] = []
            ) {
                this.id = id
                this.price = price
                this.duration = duration
                this.description = description
                this.alias = alias
                this.procedures = procedures
            }
        }

        export class Partial {
            description?: string
            alias?: string

            @ValidateNested()
            id: UUID
            
            @ValidateNested()
            price: Price

            @ValidateNested()
            duration: Int
            
            @ValidateNested()
            procedures: Procedure.Responses.Partial[]

            constructor(
                id: UUID,
                price: Price,
                duration: Int,
                procedures: Procedure.Responses.Partial[],
                description?: string,
                alias?: string,
            ) {
                this.id = id
                this.price = price
                this.duration = duration
                this.description = description
                this.alias = alias
                this.procedures = procedures
            }
        }
    }
}