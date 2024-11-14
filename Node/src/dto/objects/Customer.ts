import { ContactType } from "../enums/ContactType"

export type Customer = Parameters | Responses

type Parameters =  Registration | Create | Retrieve | HandleInvite

type Responses = Full | Partial | Verify

interface Registration {
    //contacts: 
}

interface Create {
    salonId: string | undefined
    alias: string
    //contacts:
}

interface Retrieve {
    salons: string[] | undefined
    employees: string[] | undefined
}

interface HandleInvite {
    contact: string | undefined
}

interface Full {
    id: string
    user: CustomerUser
    alias: string | undefined
    //contacts: Contact[]
}

interface Partial {
    id: string
    user: CustomerUser
    alias: string | undefined
    //contacts: Contact[]
}

interface Verify {
    //contacts: 
}