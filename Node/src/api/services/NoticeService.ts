import { client } from "../clientFactory/Client";
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { UUID } from "../../dto/tsPrimitives/UUID";
import { Int } from "../../dto/tsPrimitives/Int";
import { Notice } from "../../dto/objects/Notice";
import { CookieStorage, TestStorage } from "../clientFactory/Storage";

const Paths = {
    All:      "notifications",
    ReadOne:  "notifications/readed/(id)",
    ReadMany: "notifications/readed",
}

export class NoticeService {
    private client: AxiosInstance

    constructor() { 
        this.client = client(process.env.NODE_ENV === 'production' ? 
            new CookieStorage(cookies()) : 
            new TestStorage()
        );
    } 

    async All(): Promise<Notice.Responses.Full[]> {
        const response = await this.client.get(
            Paths.All
        )

        return response.data;
    }

    async ReadOne(id: UUID): Promise<Int> {
        const response = await this.client.put(
            Paths.ReadOne.replace("(id)", id.uuid)
        )

        return new Int(response.status)
    }

    async ReadMany(): Promise<Int> {
        const response = await this.client.put(
            Paths.ReadMany
        )

        return new Int(response.status)
    }
}