import { client } from "../clientFactory/Client";
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { UUID } from "../../dto/tsPrimitives/UUID";
import { Int } from "../../dto/tsPrimitives/Int";
import { Salon } from "../../dto/objects/Salon";

const Paths = {
    Workshops:  "salons/workshops",
    Create:     "salons",
    Retrieve:   "salons/(id)",
    Update:     "salons/(id)",
    Activate:   "salons/(id)/activate",
    Deactivate: "salons/(id)/deactivate",
    Delete:     "salons/(id)",
}

export class SalonService {
    private client: AxiosInstance

    constructor() { 
        this.client = client(process.env.NODE_ENV === 'production' ? cookies() : new Map());
    }

    async Workshops(): Promise<Salon.Responses.Partial[]> {
        const response = await this.client.get(Paths.Workshops)

        return response.data
    }

    async Create(body: Salon.Parameters.Create): Promise<Salon.Responses.Full> {
        const response = await this.client.post(
            Paths.Create, 
            body
        )

        return response.data
    }

    async Retrieve(id: UUID): Promise<Salon.Responses.Full> {
        const response = await this.client.get(
            Paths.Retrieve.replace("(id)", id.uuid)
        )

        return response.data
    }

    async Update(id: UUID, body: Salon.Parameters.Patch): Promise<Salon.Responses.Full> {
        const response = await this.client.put(
            Paths.Update.replace("(id)", id.uuid), 
            body,
        )

        return response.data
    }

    async Activate(id: UUID): Promise<Salon.Responses.Full> {
        const response = await this.client.put(
            Paths.Activate.replace("(id)", id.uuid)
        )

        return response.data
    }

    async Deactivate(id: UUID): Promise<Salon.Responses.Full> {
        const response = await this.client.put(
            Paths.Deactivate.replace("(id)", id.uuid)
        )

        return response.data
    }

    async Delete(id: UUID): Promise<Int> {
        const response = await this.client.delete(
            Paths.Delete.replace("(id)", id.uuid)
        )

        return new Int(response.status)
    }
}