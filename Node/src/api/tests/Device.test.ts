import { Auth } from "../../dto/objects/Auth";
import { AuthService } from "../services/AuthService";
import { DeviceService } from "../services/DeviceService";
import { Device } from "../../dto/objects/Device";
import { Storage } from "../clientFactory/Storage";
import { cookies } from "next/headers";

const testToken = "test_npm2"

test("Device", async () => {
    const deviceService = new DeviceService()
    const device = new Device.Parameters.System()

    const res = await deviceService.Check(device)

    console.log(res)
})