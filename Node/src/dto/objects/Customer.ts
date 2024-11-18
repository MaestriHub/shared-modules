import { ValidateNested } from "class-validator"
import { CustomerUser } from "../enums/CustomerUser"
import { UUID } from "../tsPrimitives/UUID"
import { Contact } from "./Contact"

export namespace Customer {

    export namespace Parameters {
        
        export class Create {
            @ValidateNested()
            salonId?: UUID

            alias: string

            @ValidateNested()
            contacts: Contact.Parameters.Create[]

            constructor(
                alias: string,
                contacts: Contact.Parameters.Create[],
                salonId?: UUID,
            ) {
                this.salonId = salonId
                this.alias = alias
                this.contacts = contacts
            }
        }

        export class Registration {
            @ValidateNested()
            contacts: Contact.Parameters.Create[]

            constructor(
                contacts: Contact.Parameters.Create[]
            ) {
                this.contacts = contacts
            }
        }

        export class Retrieve {
            salons?: string[] // TODO:
            employees?: string[]

            constructor(
                salons?: string[],
                employees?: string[],
            ) {
                this.salons = salons
                this.employees = employees
            }
        }

        export class HandleInvite {
            contact?: string

            constructor(
                contact?: string
            ) {
                this.contact = contact
            }
        }
    }

    export namespace Responses {
        export class Full {
            @ValidateNested()
            id: UUID

            user: CustomerUser
            alias?: string

            @ValidateNested()
            contacts: Contact.Responses.Full[]

            constructor(
                id: UUID,
                user: CustomerUser,
                contacts: Contact.Responses.Full[],
                alias?: string,
            ) {
                this.id = id
                this.user = user
                this.alias = alias
                this.contacts = contacts
            }
        }

        export class Partial {
            @ValidateNested()
            id: UUID

            user: CustomerUser
            
            @ValidateNested()
            contacts: Contact.Responses.Full[]
            alias?: string

            constructor(
                id: UUID,
                user: CustomerUser,
                contacts: Contact.Responses.Full[],
                alias?: string,
            ) {
                this.id = id
                this.user = user
                this.alias = alias
                this.contacts = contacts
            }
        }

        export class Verify {
            @ValidateNested()
            contacts: Contact.Responses.Full[]

            constructor(
                contacts: Contact.Responses.Full[]
            ) {
                this.contacts = contacts
            }
        }
    }
}