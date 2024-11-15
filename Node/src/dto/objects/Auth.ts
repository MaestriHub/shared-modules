import { Token } from "../primitives/Token"

export type Auth = Parameters | Responses

type Parameters =  AppleToken | GoogleToken

type Responses = Full | Partial

export interface AppleToken {
    token: string
    firstName: string | undefined
    lastName: string | undefined
    email: string | undefined
    emailVerified: boolean | undefined
}

export interface GoogleToken {
    token: string
    firstName: string | undefined
    lastName: string | undefined
}

export interface Full {
    accessToken: Token
    refreshToken: Token
    //user:
}

export interface Partial {
    accessToken: Token
    refreshToken: Token | undefined
}