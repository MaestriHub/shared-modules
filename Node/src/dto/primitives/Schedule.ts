import { ValidateNested } from "class-validator"
import { Int } from "../tsPrimitives/Int"
import { IsoDate } from "../tsPrimitives/IsoDate"

export namespace Schedule {

    type Types = Schedule.Week   | 
                 Schedule.Cycled | 
                 Schedule.Day    |  
                 Schedule.Empty

    export class Pattern {
        schedule: Types

        constructor(pattern: Types) {
            this.schedule = pattern
        }

        toJSON() {
            switch (true) {
            case this.schedule instanceof Schedule.Week:
                return {
                    weekly: {
                        week: this.schedule
                    }
                }
            case this.schedule instanceof Schedule.Cycled:
                return {
                    cycled: {
                        cycle: this.schedule
                    }
                }
            case this.schedule instanceof  Schedule.Day:
                return {
                    daily: {
                        day: this.schedule
                    }
                }
            case this.schedule instanceof  Schedule.Empty:
                return {
                    empty: {
                        empty: ''
                    }
                }
            }
        }

        static fromJSON(json: any): Pattern {
            if (json.weekly) {
                return new Pattern(json.weekly.week);
            } else if (json.cycled) {
                return new Pattern(json.cycled.cycle);
            } else if (json.daily) {
                return new Pattern(json.daily.day);
            } else if (json.empty) {
                return new Pattern(new Empty());
            } else {
                throw new Error("Unknown Schedule pattern type");
            }
        }
    }

    export class Week {
        monday?: Day
        tuesday?: Day
        wednesday?: Day
        thursday?: Day
        friday?: Day
        saturday?: Day
        sunday?: Day

        constructor (
            monday?: Day,
            tuesday?: Day,
            wednesday?: Day,
            thursday?: Day,
            friday?: Day,
            saturday?: Day,
            sunday?: Day
        ) {
            this.monday = monday
            this.tuesday = tuesday
            this.wednesday = wednesday
            this.thursday = thursday
            this.friday = friday
            this.saturday = saturday
            this.sunday = sunday
        }
    }

    export class Cycled {
        startDay: IsoDate
        workDays: Map<Int, Day>

        @ValidateNested()
        restDays: Int

        constructor (
            startDay: IsoDate,
            workDays: Map<Int, Day>,
            restDays: Int
        ) {
            this.startDay = startDay
            this.workDays = workDays
            this.restDays = restDays
        }
    }
    
    export class Day {
        workTime: String
        offTime: string[]

        constructor (
            workTime: String,
            offTime: string[]
        ) {
            this.workTime = workTime
            this.offTime = offTime
        }
    }
    
    export class Empty {}
}