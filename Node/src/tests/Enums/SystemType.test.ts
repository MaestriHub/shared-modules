import { SystemType } from "../../dto/enums/SystemType"

test("Schedule empty", async () => {
    const sys = new SystemType(new SystemType.Android("10.0"))
    const json = sys.toJSON()
    console.log(sys)
    console.log(json)
    const newSys: SystemType = SystemType.fromJSON(json)
    
    console.log(sys)
    console.log(json)
    console.log(newSys)
    
    expect(JSON.stringify(sys) === JSON.stringify(newSys)).toBe(true)
})