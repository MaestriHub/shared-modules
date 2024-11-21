import { DeviceService } from "../../api/services/DeviceService";
import { Device } from "../../dto/objects/Device";

test("Device", async () => {
    const deviceService = new DeviceService()
    const device = new Device.Parameters.System()

    const res = await deviceService.Check(device)
})