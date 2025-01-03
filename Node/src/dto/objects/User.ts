import { Contact } from "./Contact"
import { UserRoleSet } from '../optionSet/UserRoleSet'
import { MaestriPermissionSet } from '../optionSet/MaestriPermissionSet'
import { UUID } from "../tsPrimitives/UUID"
import { ValidateNested } from "class-validator"

export namespace User {
    
    export namespace Parameters {

        export class Patch {
            nickname?: string
            avatar?: URL

            @ValidateNested()
            contact?: Contact.Parameters.Create

            constructor(
                nickname?: string,
                avatar?: URL,
                contact?: Contact.Parameters.Create,
            ) {
                this.nickname = nickname
                this.avatar = avatar
                this.contact = contact
            }
        }
    }

    export namespace Responses {
        
        export class Full {
            nickname: string
            avatar?: URL

            @ValidateNested()
            id: UUID

            @ValidateNested()
            options: UserRoleSet

            @ValidateNested()
            permissions: MaestriPermissionSet

            @ValidateNested()
            contact?: Contact.Responses.Full

            @ValidateNested()
            customerId?: UUID

            @ValidateNested()
            professionalId?: UUID

            constructor(
                id: UUID,
                options: UserRoleSet,
                permissions: MaestriPermissionSet,
                nickname: string,
                avatar?: URL,
                contact?: Contact.Responses.Full,
                customerId?: UUID,
                professionalId?: UUID,
            ) {
                this.id = id
                this.avatar = avatar
                this.nickname = nickname
                this.contact = contact
                this.options = options
                this.permissions = permissions
                this.customerId = customerId
                this.professionalId = professionalId
            }
        }
        
        export class Partial {
            avatar?: URL
            nickname: string

            constructor(
                nickname: string,
                avatar?: URL,
            ) {
                this.avatar = avatar
                this.nickname = nickname
            }
        }
    }
}