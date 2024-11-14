import { Token } from "../primitives/Token"

export type Auth = Parameters | Responses

type Parameters =  AppleToken | GoogleToken

type Responses = Full | Partial

interface AppleToken {
    token: string
    firstName: string | undefined
    lastName: string | undefined
    email: string | undefined
    emailVerified: boolean | undefined
}

interface GoogleToken {
    token: string
    firstName: string | undefined
    lastName: string | undefined
}

interface Full {
    accessToken: Token
    refreshToken: Token
    //user:
}

interface Partial {
    accessToken: Token
    refreshToken: Token | undefined
}