import { Price } from "../primitives/Price"
import { Token } from "../primitives/Token"

export type Complex = Parameters | Responses

type Parameters =  Retrieve | Create | Patch

type Responses = Full | Partial

interface Retrieve {
    salons: string[] | undefined
    employees: string[] | undefined
}

interface Create {
    price: Price
    duration: Int
    description: string | undefined
    alias: string | undefined
    procedureIds: string[]
}

interface Patch {
    price: Price
    duration: Int
    description: string | undefined
    alias: string | undefined
    procedureIds: string[]
}

interface Full {
    id: string
    price: Price
    duration: Int
    description: string | undefined
    alias: string | undefined
    //procedureIds: string[]
    //user:
}

interface Partial {
    accessToken: Token
    refreshToken: Token | undefined
}