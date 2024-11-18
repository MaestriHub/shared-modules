import { ProfessionalEmployee } from "../enums/ProfessionalEmployee"

export namespace Employee {

    export namespace Parameters {
        
        export class Retrieve {
            salonId: string[]

            constructor(
                salonId: string[]
            ) {
                this.salonId = salonId
            }
        }

        export class Invite {
            salonId: string
            positionId: string
            //contacts
            //timetable
            description?: string

            constructor(
                salonId: string,
                positionId: string,
                //contacts
                //timetable
                description?: string
            ) {
                this.salonId = salonId
                this.positionId = positionId
                this.description = description
            }
        }

        export class Patch {
            positionId?: string

            constructor(
                positionId?: string
            ) {
                this.positionId = positionId
            }
        }
    }

    export namespace Responses {
        export class Full {
            id: string
            user: ProfessionalEmployee
            description?: string
            canEdit: boolean
            //contacts
            salonId: string
            //position?: string

            constructor(
                id: string,
                user: ProfessionalEmployee,
                canEdit: boolean,
                salonId: string,
                description?: string,
                //position?: string
            ) {
                this.id = id
                this.user = user
                this.description = description
                this.canEdit = canEdit
                this.salonId = salonId
                //this.position = position
            }
        }

        export class Partial {
            id: string
            // user:
            // contacts: 
            // position:

            constructor(
                id: string
            ) {
                this.id = id
            }
        }
    }
}