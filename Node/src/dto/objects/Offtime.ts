import { IsTimeZone, ValidateNested } from "class-validator"
import { DateInterval } from "../tsPrimitives/DateInterval"
import { Decimal } from "../tsPrimitives/Decimal"
import { UUID } from "../tsPrimitives/UUID"

export namespace Offtime {

    export namespace Parameters {

        export class Create {
            @ValidateNested()
            interval: DateInterval

            @ValidateNested()
            coefficient: Decimal

            reason?: string

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
    }

    export namespace Responses {

        export class Full {
            @ValidateNested()
            id: UUID

            @ValidateNested()
            interval: DateInterval

            reason?: string

            @IsTimeZone()
            timeZoneId: string

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