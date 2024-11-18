import { DateInterval } from "../tsPrimitives/DateInterval"
import { UUID } from "../tsPrimitives/UUID"
import { Schedule } from "../primitives/Schedule"
import { TimetableOwner } from "../enums/TimetableOwner"
import { AppointmentType } from "../enums/AppointmentType"

export namespace Timetable {

    export namespace Parameters {

        export namespace Create {

            export class Pattern {
                schedule: Schedule.Pattern
                startAt: Date
                endAt?: Date

                constructor(
                    schedule: Schedule.Pattern, 
                    startAt: Date, 
                    endAt?: Date
                ) {
                    this.schedule = schedule
                    this.startAt = startAt
                    this.endAt = endAt
                }
            }

            export class Flexible {
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
            owners: TimetableOwner[]
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
            intervals: Intervals
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
            owner: TimetableOwner
            intervals: Intervals
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