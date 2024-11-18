import { Contact } from "./Contact"
import { UserRoleSet } from '../optionSet/UserRoleSet'
import { MaestriPermissionSet } from '../optionSet/MaestriPermissionSet'

export namespace User {
    
    export namespace Parameters {

        export class Patch {
            nickname?: string
            avatar?: URL
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
            id: string
            nickname: string
            options: UserRoleSet
            permissions: MaestriPermissionSet
            avatar?: URL
            contact?: Contact.Responses.Full

            constructor(
                id: string,
                options: UserRoleSet,
                permissions: MaestriPermissionSet,
                nickname: string,
                avatar?: URL,
                contact?: Contact.Responses.Full,
            ) {
                this.id = id
                this.avatar = avatar
                this.nickname = nickname
                this.contact = contact
                this.options = options
                this.permissions = permissions
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