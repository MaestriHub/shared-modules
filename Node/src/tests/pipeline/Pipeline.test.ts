import { AuthService } from "../../api/services/AuthService"
import { DeviceService } from "../../api/services/DeviceService"
import { SalonService } from "../../api/services/SalonService"
import { UserService } from "../../api/services/UserService"
import { ContactType } from "../../dto/enums/ContactType"
import { SalonType } from "../../dto/enums/SalonType"
import { Contact } from "../../dto/objects/Contact"
import { Device } from "../../dto/objects/Device"
import { Professional } from "../../dto/objects/Professional"
import { Salon } from "../../dto/objects/Salon"
import { Timetable } from "../../dto/objects/Timetable"
import { Address } from "../../dto/primitives/Address"
import { Schedule } from "../../dto/primitives/Schedule"
import { IsoDate } from "../../dto/tsPrimitives/IsoDate"

const testToken = "hfgjghkjykuy"

test("Flow", async () => {
    const deviceService = new DeviceService()
    const device = new Device.Parameters.System()
    await deviceService.Check(device)
    
    const authService = new AuthService()
    await authService.TestAuth(testToken)

    const userService = new UserService()
    const professionalConfig = new Professional.Parameters.Create()
    await userService.CreateProfessional(professionalConfig)

    const salonService = new SalonService()
    const schedulePattern = new Schedule.Pattern(new Schedule.Empty())

    const salonConfig: Salon.Parameters.Create = {
        name: "Test",
        type: SalonType.master,
        timeZoneId: "GMT",
        localeId: "RU",
        timetable: new Timetable.Parameters.Create.Pattern(schedulePattern, new IsoDate(new Date(Date.parse("2024-10-20T00:00:00Z"))), new IsoDate(new Date(Date.parse("2024-10-21T00:00:00Z")))),
        address: new Address("Address", "Rostov", "Russia", 0, 0),
        contacts: [new Contact.Parameters.Create("asdadaxzkvkzx@mail.com", ContactType.email, true)],
        logo: new URL("https://www.eltiempo.com/files/image_640_428"),
        description: "Test",
    }
    const SalonFull = await salonService.Create(salonConfig)
    console.log(SalonFull)
})