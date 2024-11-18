import { CustomerUser } from "../enums/CustomerUser"
import { Contact } from "./Contact"

export namespace Customer {

    export namespace Parameters {
        
        export class Create {
            salonId?: string
            alias: string
            contacts: Contact.Parameters.Create[]

            constructor(
                alias: string,
                contacts: Contact.Parameters.Create[],
                salonId?: string,
            ) {
                this.salonId = salonId
                this.alias = alias
                this.contacts = contacts
            }
        }

        export class Registration {
            contacts: Contact.Parameters.Create[]

            constructor(
                contacts: Contact.Parameters.Create[]
            ) {
                this.contacts = contacts
            }
        }

        export class Retrieve {
            salons?: string[]
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
            id: string
            user: CustomerUser
            alias?: string
            contacts: Contact.Responses.Full[]

            constructor(
                id: string,
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
            id: string
            user: CustomerUser
            contacts: Contact.Responses.Full[]
            alias?: string

            constructor(
                id: string,
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
            contacts: Contact.Responses.Full[]

            constructor(
                contacts: Contact.Responses.Full[]
            ) {
                this.contacts = contacts
            }
        }
    }
}