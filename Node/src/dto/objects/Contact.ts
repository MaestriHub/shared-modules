import { ContactType } from "../enums/ContactType"

export type Contact = Parameters | Responses

type Parameters =  Create | SendCode | Verify

type Responses = Full | Verified

interface Create {
    value: string
    type: ContactType
    isVerify: boolean | undefined
}

interface SendCode {
    recaptchaToken: string | undefined
}

interface Verify {
    code: string
}

interface Full {
    id: string // TODO: UUID представлено как строка??
    value: string
    isVerify: boolean
    type: ContactType
}

interface Verified {
    isVerified: boolean
}