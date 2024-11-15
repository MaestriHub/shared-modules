import { Price } from "../primitives/Price"
import { Int } from "../tsPrimitives/Int"

export namespace Complex {

    export namespace Parameters {
        
        export class Retrieve {
            salons: string[] | undefined
            employees: string[] | undefined
        }

        export class Create {
            price: Price
            duration: Int
            description: string | undefined
            alias: string | undefined
            procedureIds: string[]
        }

        export class Patch {
            price: Price
            duration: Int
            description: string | undefined
            alias: string | undefined
            procedureIds: string[]
        }
    }

    export namespace Responses {
        
        export class Full {
            id: string
            price: Price
            duration: Int
            description: string | undefined
            alias: string | undefined
            //procedureIds: string[]
        }

        export class Partial {
            id: string
            price: Price
            duration: Int
            description: string | undefined
            alias: string | undefined
            //procedureIds: string[]
        }
    }
}