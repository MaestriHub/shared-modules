import { Int } from "../tsPrimitives/Int"
import { ServiceCategory } from "../enums/ServiceCategory"
import { Procedure } from "./Procedure"
import { Price } from "../primitives/Price"

export namespace Service {

    export namespace Parameters {
        
        export class Retrieve {
            salons?: string[]
            employees?: string[]
            value?: string
            page: Int
            per: Int

            constructor(
                page: Int,
                per: Int,
                salons?: string[],
                employees?: string[],
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
            salon?: string

            constructor(
                salon?: string
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
            id: string
            title: string
            description: string
            category: ServiceCategory
            procedure: Procedure.Responses.Full[]

            constructor(
                id: string,
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
            id: string
            title: string
            description: string
            category: ServiceCategory
            minPrice?: Price
            minDuration?: Int

            constructor(
                id: string,
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
            id: string
            title: string
            description: string
            category: ServiceCategory

            constructor(
                id: string,
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