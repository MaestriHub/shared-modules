import { Int } from "../../dto/tsPrimitives/Int"
import { ezValidate } from "../../dto/validate/EzValidate"

test("Int ok", async () => {
    const int = new Int(5)
    await ezValidate(int)
})

test("Int error", async ()  => {
    const int = new Int(5.5)
    ezValidate(int).catch(e => expect(e).toBe("parse Int error"))
})