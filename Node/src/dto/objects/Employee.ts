
export type Employee = Parameters | Responses

type Parameters =  Retrieve | Invite | Patch 

type Responses = Full | Partial

interface Retrieve {
    salonId: string[]
}

interface Invite {
    salonId: string
    positionId: string
    //contacts
    //timetable
    description: string | undefined
}

interface Patch {
    positionId: string | undefined
}

interface Full {
    id: string
    user: ProfessionalEmployee
    description: string | undefined
    canEdit: boolean
    //contacts
    salonId: string
    //position: string | undefined
}

interface Partial {
    id: string
    // user:
    // contacts: 
    // position: 
}