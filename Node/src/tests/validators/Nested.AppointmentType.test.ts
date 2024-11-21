import { AppointmentType } from "../../dto/enums/AppointmentType"
import { UUID } from "../../dto/tsPrimitives/UUID"
import { ezValidate } from "../../dto/validate/EzValidate"

test("AppointmenType error", async () => {
    let id = new UUID()
    id.uuid = "хуй"
    const procedure = new AppointmentType.Procedure(id)
    ezValidate(procedure).catch(e => expect(e).toBe("parse Procedure error"))
})

test("AppointmenType ok", async ()  => {
    const procedure = new AppointmentType.Procedure(new UUID())
    await ezValidate(procedure)
})