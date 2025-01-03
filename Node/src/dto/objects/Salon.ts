import { Address } from "../primitives/Address"
import { SalonType } from "../enums/SalonType"
import { Timetable } from "./Timetable"
import { Contact } from "./Contact"
import { UUID } from "../tsPrimitives/UUID"
import { IsLocale, IsTimeZone, ValidateNested } from "class-validator"

export namespace Salon {

    export namespace Parameters {
    
        export class Create {
            name: string
            type: SalonType
            logo?: URL
            description?: string

            @IsTimeZone()
            timeZoneId: string

            @IsLocale()
            localeId: string

            @ValidateNested()
            timetable: Timetable.Parameters.Create.Pattern

            @ValidateNested()
            address: Address

            @ValidateNested()
            contacts: Contact.Parameters.Create[]

            constructor(
                name: string,
                type: SalonType,
                timeZoneId: string,
                localeId: string,
                timetable: Timetable.Parameters.Create.Pattern,
                address: Address,
                contacts: Contact.Parameters.Create[],
                logo?: URL,
                description?: string,
            ) {
                this.name = name
                this.type = type
                this.logo = logo
                this.timeZoneId = timeZoneId
                this.localeId = localeId
                this.description = description
                this.timetable = timetable
                this.address = address
                this.contacts = contacts
            }
        }

        export class Patch {
            name?: string
            type?: SalonType
            description?: string
            logo?: URL

            constructor(
                name?: string,
                type?: SalonType,
                description?: string,
                logo?: URL,
            ) {
                this.name = name
                this.type = type
                this.description = description
                this.logo = logo
            }
        }
    }

    export namespace Responses {

        export class Full {
            @ValidateNested()
            id: UUID
            
            name: string
            type: SalonType
            description?: string
            logo?: URL
            isActive: boolean
            canEdit: boolean
            isFavorite: boolean
            
            @ValidateNested()
            address: Address

            @IsLocale()
            localeId: string

            @IsTimeZone()
            timeZoneId: string

            constructor(
                id: UUID,
                name: string,
                type: SalonType,
                address: Address,
                isActive: boolean,
                canEdit: boolean,
                isFavorite: boolean,
                localeId: string,
                timeZoneId: string,
                description?: string,
                logo?: URL,
            ) {
                this.id = id
                this.name = name
                this.type = type
                this.description = description
                this.logo = logo
                this.address = address
                this.isActive = isActive
                this.canEdit = canEdit
                this.isFavorite = isFavorite
                this.localeId = localeId
                this.timeZoneId = timeZoneId
            }
        }

        export class Partial {
            @ValidateNested()
            id: UUID
            
            @ValidateNested()
            address: Address
            
            name: string
            type: SalonType
            logo?: URL
            isFavorite: boolean

            constructor(
                id: UUID,
                name: string,
                type: SalonType,
                address: Address,
                isFavorite: boolean,
                logo?: URL, 
            ) {
                this.id = id
                this.name = name
                this.type = type
                this.address = address
                this.isFavorite = isFavorite
                this.logo = logo
            }
        }
    }
} 