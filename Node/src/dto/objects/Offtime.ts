import { DateInterval } from "../tsPrimitives/DateInterval"
import { UUID } from "../tsPrimitives/UUID"

export namespace Offtime {

    export namespace Parameters {

        export class Create {
            interval: DateInterval
            coefficient: number //TODO: decimal
            reason?: string

            constructor(
                interval: DateInterval,
                coefficient: number,
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
            id: UUID
            interval: DateInterval
            reason?: string
            timeZoneId: string
            coefficient: number //Decimal

            constructor(
                id: UUID,
                interval: DateInterval,
                timeZoneId: string,
                coefficient: number,
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
            id: UUID
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