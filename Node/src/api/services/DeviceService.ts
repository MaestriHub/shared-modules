import { client } from "../clientFactory/Client";
import { Device } from "../../dto/objects/Device"
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { CookieStorage, TestStorage } from "../clientFactory/Storage";

const Paths = {
    DeviceCheck: "devices",
}

export class DeviceService {
    private client: AxiosInstance

    constructor() { 
        this.client = client(process.env.NODE_ENV === 'production' ? 
            new CookieStorage(cookies()) : 
            new TestStorage()
        );
    }
  
    async Check(body: Device.Parameters.System): Promise<Device.Responses.Full> {
        const response = await this.client.post(
            Paths.DeviceCheck, 
            body
        )

        return response.data;
    }
}
