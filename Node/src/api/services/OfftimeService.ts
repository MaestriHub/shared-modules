import { client } from "../clientFactory/Client";
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { UUID } from "../../dto/tsPrimitives/UUID";
import { Int } from "../../dto/tsPrimitives/Int";
import { TimetableOwner } from "../../dto/enums/TimetableOwner";
import { Offtime } from "../../dto/objects/Offtime";

const Paths = {
    Create: "offtime/(owner)",
    All:    "offtime/(owner)",
    Delete: "offtime/(id)",
}

export class OfftimeService {
    private client: AxiosInstance

    constructor() { 
        this.client = client(process.env.NODE_ENV === 'production' ? cookies() : new Map());
    }

    async Create(owner: TimetableOwner, body: Offtime.Parameters.Create): Promise<Offtime.Responses.Full> {
        const response = await this.client.post(
            Paths.Create.replace("(owner)", JSON.stringify(owner)), 
            body
        )

        return response.data;
    }

    async All(owner: TimetableOwner): Promise<Offtime.Responses.Full[]> {
        const response = await this.client.get(
            Paths.All.replace("(owner)", JSON.stringify(owner))
        )

        return response.data;
    }

    async Delete(id: UUID): Promise<Int> {
        const response = await this.client.delete(
            Paths.Delete.replace("(id)", id.uuid)
        )

        return response.data;
    }
}
