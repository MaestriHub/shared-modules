import { IsTimeZone, ValidateNested } from "class-validator"
import { DateInterval } from "../tsPrimitives/DateInterval"
import { Decimal } from "../tsPrimitives/Decimal"
import { UUID } from "../tsPrimitives/UUID"
import { TimetableOwner } from "../enums/TimetableOwner"

export namespace Offtime {

    export namespace Parameters {

        export class Create {
            reason?: string

            @ValidateNested()
            interval: DateInterval

            @ValidateNested()
            coefficient: Decimal

            constructor(
                interval: DateInterval,
                coefficient: Decimal,
                reason?: string
            ) {
                this.interval = interval
                this.coefficient = coefficient
                this.reason = reason
            }
        }

        export class Retrieve {
            @ValidateNested()
            owners: TimetableOwner[]

            @ValidateNested()
            period: DateInterval

            constructor(
                owners: TimetableOwner[],
                period: DateInterval
            ) {
                this.owners = owners
                this.period = period
            }
        }
    }

    export namespace Responses {

        export class Full {
            reason?: string

            @ValidateNested()
            id: UUID

            @ValidateNested()
            interval: DateInterval

            @IsTimeZone()
            timeZoneId: string

            @ValidateNested()
            coefficient: Decimal

            constructor(
                id: UUID,
                interval: DateInterval,
                timeZoneId: string,
                coefficient: Decimal,
                reason?: string
            ) {
                this.id = id
                this.interval = interval
                this.reason = reason
                this.timeZoneId = timeZoneId
                this.coefficient = coefficient
            }
        }

        export class Partial {
            @ValidateNested()
            id: UUID
            
            @ValidateNested()
            interval: DateInterval 

            constructor(
                id: UUID,
                interval: DateInterval
            ) {
                this.id = id
                this.interval = interval
            }
        }
    }
}