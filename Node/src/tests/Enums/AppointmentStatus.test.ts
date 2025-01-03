import { AppointmentStatus } from "../../dto/enums/AppointmentStatus";

test("AppointmentStatus toJson", async () => {
  const appointmentStatus = AppointmentStatus.bothApproved
  expect(JSON.stringify(appointmentStatus)).toBe('"bothApproved"');
})

test("AppointmentStatus fromJson", async () => {
  const json = 'bothApproved'
  const appointmentType = AppointmentStatus.bothApproved;
  expect(AppointmentStatus[json]).toBe(appointmentType);
})
