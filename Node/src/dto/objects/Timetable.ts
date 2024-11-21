import { DateInterval } from "../tsPrimitives/DateInterval"
import { UUID } from "../tsPrimitives/UUID"
import { Schedule } from "../primitives/Schedule"
import { TimetableOwner } from "../enums/TimetableOwner"
import { AppointmentType } from "../enums/AppointmentType"
import { IsTimeZone, ValidateNested } from "class-validator"
import { IsoDate } from "../tsPrimitives/IsoDate"

export namespace Timetable {

    export namespace Parameters {

        export namespace Create {

            export class Pattern {
                startAt: IsoDate
                endAt?: IsoDate

                @ValidateNested()
                schedule: Schedule.Pattern

                constructor(
                    schedule: Schedule.Pattern, 
                    startAt: IsoDate, 
                    endAt?: IsoDate
                ) {
                    this.schedule = schedule
                    this.startAt = startAt
                    this.endAt = endAt
                }
            }

            export class Flexible {
                @ValidateNested()
                workDays: Map<Date, Schedule.Day>

                constructor(
                    workDays: Map<Date, Schedule.Day>
                ) {
                    this.workDays = workDays
                }
            }
        }

        export class SearchSlot {
            appointmentType: AppointmentType

            @ValidateNested()
            customerId?: UUID

            constructor(
                appointmentType: AppointmentType,
                customerId?: UUID
            ) {
                this.appointmentType = appointmentType
                this.customerId = customerId
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

        type Intervals = DateInterval[]

        export class Slots {
            @ValidateNested()
            intervals: Intervals

            @IsTimeZone()
            timeZoneId: string

            constructor(
                intervals: Intervals,
                timeZoneId: string
            ) {
                this.intervals = intervals
                this.timeZoneId = timeZoneId
            }
        }

        export class Schedule {
            @ValidateNested()
            owner: TimetableOwner

            @ValidateNested()
            intervals: Intervals
            
            @IsTimeZone()
            timeZoneId: string

            constructor(
                owner: TimetableOwner,
                intervals: Intervals,
                timeZoneId: string
            ) {
                this.owner = owner
                this.intervals = intervals
                this.timeZoneId = timeZoneId
            }
        }
    }
}