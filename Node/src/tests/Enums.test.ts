import { AppointmentType, Types } from "../dto/enums/AppointmentType";
import { UUID } from '../dto/tsPrimitives/UUID';

test("AppointmentType toJson", async () => {
    const appointmentType = new AppointmentType(Types.PROCEDURE, new UUID())
    expect(appointmentType.type).toBe(Types.PROCEDURE);
})

test("AppointmentType fromJson", async () => {
    const uuid = "123e4567-e89b-12d3-a456-426655440000"
    const json = {
        "foo": "bar",
        "procedure": {
          "id": uuid
        }
      };
    const appointmentType = AppointmentType.fromJSON(json);
    expect(appointmentType.type).toBe(Types.PROCEDURE);
    expect(appointmentType.id).toBe(uuid)
})


