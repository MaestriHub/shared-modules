import { ValidateNested } from "class-validator"
import { ProfessionalEmployee } from "../enums/ProfessionalEmployee"
import { UUID } from "../tsPrimitives/UUID"
import { Contact } from "./Contact"
import { Timetable } from "./Timetable"
import { Position } from "./Position"
import { User } from "./User"

export namespace Employee {

    export namespace Parameters {
        
        export class Retrieve {
            @ValidateNested()
            salonsId: UUID[]

            constructor(
                salonsId: UUID[]
            ) {
                this.salonsId = salonsId
            }
        }

        export class Invite {
            description?: string

            @ValidateNested()
            salonId: UUID

            @ValidateNested()
            positionId: UUID
            
            @ValidateNested()
            contacts: Contact.Parameters.Create[]

            @ValidateNested()
            timetable?: Timetable.Parameters.Create.Pattern

            constructor(
                salonId: UUID,
                positionId: UUID,
                contacts: Contact.Parameters.Create[],
                timetable?: Timetable.Parameters.Create.Pattern,
                description?: string
            ) {
                this.salonId = salonId
                this.positionId = positionId
                this.contacts = contacts
                this.timetable = timetable
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
            description?: string
            canEdit: boolean

            @ValidateNested()
            id: UUID

            @ValidateNested()
            user: ProfessionalEmployee
            
            @ValidateNested()
            contacts: Contact.Responses.Full[]

            @ValidateNested()
            salonId: UUID
            
            @ValidateNested()
            position: Position.Responses.Full

            constructor(
                id: UUID,
                user: ProfessionalEmployee,
                canEdit: boolean,
                contacts: Contact.Responses.Full[],
                salonId: UUID,
                position: Position.Responses.Full,
                description?: string,
            ) {
                this.id = id
                this.user = user
                this.description = description
                this.canEdit = canEdit
                this.salonId = salonId
                this.contacts = contacts
                this.position = position
            }
        }

        export class Partial {
            @ValidateNested()
            id: UUID
            
            @ValidateNested()
            user?: User.Responses.Partial

            @ValidateNested()
            contacts: Contact.Responses.Full[]

            @ValidateNested()
            position: Position.Responses.Partial

            constructor(
                id: UUID,
                contacts: Contact.Responses.Full[],
                position: Position.Responses.Partial,
                user?: User.Responses.Partial,
            ) {
                this.id = id
                this.contacts = contacts
                this.position = position
                this.user = user
            }
        }
    }
}