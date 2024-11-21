import { client } from "../clientFactory/Client";
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { UUID } from "../../dto/tsPrimitives/UUID";
import { Int } from "../../dto/tsPrimitives/Int";
import { Position } from "../../dto/objects/Position";
import { CookieStorage, TestStorage } from "../clientFactory/Storage";

const Paths = {
    Create:   "positions/salon/(salonId)",
    All:      "positions/salon/(salonId)",
    Retrieve: "positions/(id)",
    Update:   "positions/(id)",
    Delete:   "positions/(id)",
}

export class PositionService {
    private client: AxiosInstance

    constructor() { 
        this.client = client(process.env.NODE_ENV === 'production' ? 
            new CookieStorage(cookies()) : 
            new TestStorage()
        );
    }

    async Create(salonId: UUID, body: Position.Parameters.Create): Promise<Position.Responses.Full> {
        const response = await this.client.post(
            Paths.Create.replace("(salonId)", salonId.uuid),
            body
        )

        return response.data;
    }

    async All(salonId: UUID): Promise<Position.Responses.Full[]> {
        const response = await this.client.get(
            Paths.All.replace("(salonId)", salonId.uuid),
        )

        return response.data;
    }

    async Retrieve(id: UUID): Promise<Position.Responses.Full> {
        const response = await this.client.get(
            Paths.Retrieve.replace("(id)", id.uuid)
        )

        return response.data;
    }

    async Update(id: UUID, body: Position.Parameters.Patch): Promise<Position.Responses.Full> {
        const response = await this.client.put(
            Paths.Update.replace("(id)", id.uuid), 
            body,
        )

        return response.data;
    }

    async Delete(id: UUID): Promise<Int> {
        const response = await this.client.delete(
            Paths.Delete.replace("(id)", id.uuid)
        )

        return new Int(response.status);
    }
}