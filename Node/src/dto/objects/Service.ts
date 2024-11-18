import { Int } from "../tsPrimitives/Int"
import { ServiceCategory } from "../enums/ServiceCategory"
import { Procedure } from "./Procedure"
import { Price } from "../primitives/Price"
import { UUID } from "../tsPrimitives/UUID"
import { ValidateNested } from "class-validator"

export namespace Service {

    export namespace Parameters {
        
        export class Retrieve {
            @ValidateNested()
            salons?: UUID[]

            @ValidateNested()
            employees?: UUID[]

            value?: string

            @ValidateNested()
            page: Int

            @ValidateNested()
            per: Int

            constructor(
                page: Int,
                per: Int,
                salons?: UUID[],
                employees?: UUID[],
                value?: string,
            ) {
                this.salons = salons
                this.employees = employees
                this.value = value
                this.page = page
                this.per = per
            }
        }

        export class RetrieveFull {
            @ValidateNested()
            salon?: UUID

            constructor(
                salon?: UUID
            ) {
                this.salon = salon
            }
        }

        export class Create {
            title: string
            description: string
            category: ServiceCategory
            language?: string

            constructor(
                title: string,
                description: string,
                category: ServiceCategory,
                language?: string,
            ) {
                this.title = title
                this.description = description
                this.category = category
                this.language = language
            }
        }

        export class Patch {
            title?: string
            description?: string
            category?: ServiceCategory
            language?: string

            constructor(
                title?: string,
                description?: string,
                category?: ServiceCategory,
                language?: string,
            ) {
                this.title = title
                this.description = description
                this.category = category
                this.language = language
            }   
        }
    }

    export namespace Responses {

        export class Full {
            @ValidateNested()
            id: UUID

            title: string
            description: string
            category: ServiceCategory

            @ValidateNested()
            procedure: Procedure.Responses.Full[]

            constructor(
                id: UUID,
                title: string,
                description: string,
                category: ServiceCategory,
                procedure: Procedure.Responses.Full[],
            ) {
                this.id = id
                this.title = title
                this.description = description
                this.category = category
                this.procedure = procedure
            }
        }

        export class Partial {
            @ValidateNested()
            id: UUID

            title: string
            description: string
            category: ServiceCategory

            @ValidateNested()
            minPrice?: Price

            @ValidateNested()
            minDuration?: Int

            constructor(
                id: UUID,
                title: string,
                description: string,
                category: ServiceCategory,
                minPrice?: Price,
                minDuration?: Int,
            ) {
                this.id = id
                this.title = title
                this.description = description
                this.category = category
                this.minPrice = minPrice
                this.minDuration = minDuration
            }
        }

        export class Micro {
            @ValidateNested()
            id: UUID

            title: string
            description: string
            category: ServiceCategory

            constructor(
                id: UUID,
                title: string,
                description: string,
                category: ServiceCategory,
            ) {
                this.id = id
                this.title = title
                this.description = description
                this.category = category
            }
        }
    }
}