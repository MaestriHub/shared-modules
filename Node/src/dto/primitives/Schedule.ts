import { Int } from "../tsPrimitives/Int"

export namespace Schedule {

    export class Pattern {
        //TODO: add other patterns
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
        startDay: Date
        workDays: Map<Int, Day>
        restDays: Int

        constructor (
            startDay: Date,
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
}