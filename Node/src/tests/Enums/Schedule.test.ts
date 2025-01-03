import { Schedule } from "../../dto/primitives/Schedule";
import { Int } from "../../dto/tsPrimitives/Int";
import { IsoDate } from "../../dto/tsPrimitives/IsoDate";

test("Schedule day", async () => {
    const day = new Schedule.Pattern(new Schedule.Day("10:00", ["10:00"]))
    const json = day.toJSON()
    const newSchedule: Schedule.Pattern = Schedule.Pattern.fromJSON(json)
    expect(JSON.stringify(day) === JSON.stringify(newSchedule)).toBe(true)
})
  
test("Schedule cycle", async () => {
    const cycle = new Schedule.Pattern(
        new Schedule.Cycled(
            new IsoDate(), 
            new Map([[new Int(1), new Schedule.Day("10:00", ["10:00"])]]),
            new Int(5)
        ))
    const json = cycle.toJSON()
    const newSchedule: Schedule.Pattern = Schedule.Pattern.fromJSON(json)
    expect(JSON.stringify(cycle) === JSON.stringify(newSchedule)).toBe(true)
})
  
test("Schedule week", async () => {
    const week = new Schedule.Pattern(new Schedule.Week(
        undefined,
        undefined,
        undefined,
        new Schedule.Day("10:00", ["10:00"]),
        undefined,
        undefined,
        undefined
    ))
    const json = week.toJSON()
    const newSchedule: Schedule.Pattern = Schedule.Pattern.fromJSON(json)
    expect(JSON.stringify(week) === JSON.stringify(newSchedule)).toBe(true)
})
  
test("Schedule empty", async () => {
    const empty = new Schedule.Pattern(new Schedule.Empty())
    const json = empty.toJSON()
    const newSchedule: Schedule.Pattern = Schedule.Pattern.fromJSON(json)
    expect(JSON.stringify(empty) === JSON.stringify(newSchedule)).toBe(true)
})