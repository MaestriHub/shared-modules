import { ValidateNested } from "class-validator"
import { ProfessionalEmployee } from "../enums/ProfessionalEmployee"
import { UUID } from "../tsPrimitives/UUID"

export namespace Employee {

    export namespace Parameters {
        
        export class Retrieve {
            @ValidateNested()
            salonId: UUID[]

            constructor(
                salonId: UUID[]
            ) {
                this.salonId = salonId
            }
        }

        export class Invite {
            @ValidateNested()
            salonId: UUID

            @ValidateNested()
            positionId: UUID
            //contacts
            //timetable
            description?: string

            constructor(
                salonId: UUID,
                positionId: UUID,
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
            @ValidateNested()
            positionId?: UUID

            constructor(
                positionId?: UUID
            ) {
                this.positionId = positionId
            }
        }
    }

    export namespace Responses {
        export class Full {
            @ValidateNested()
            id: UUID

            user: ProfessionalEmployee
            description?: string
            canEdit: boolean
            //contacts

            @ValidateNested()
            salonId: UUID
            //position?: string

            constructor(
                id: UUID,
                user: ProfessionalEmployee,
                canEdit: boolean,
                salonId: UUID,
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
            @ValidateNested()
            id: UUID
            // user:
            // contacts: 
            // position:

            constructor(
                id: UUID
            ) {
                this.id = id
            }
        }
    }
}