import { client } from "../clientFactory/Client";
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { UUID } from "../../dto/tsPrimitives/UUID";
import { Int } from "../../dto/tsPrimitives/Int";
import { Service } from "../../dto/objects/Service";

const Paths = {
    All:      "services",
    Create:   "services",
    Retrieve: "services/(id)",
    Update:   "services/(id)",
    Delete:   "services/(id)",
}

export class ServicesService {
    private client: AxiosInstance

    constructor() { 
        this.client = client(process.env.NODE_ENV === 'production' ? cookies() : new Map());
    }

    async All(query: Service.Parameters.Retrieve): Promise<Service.Responses.Full[]> {
        const response = await this.client.get(
            Paths.All,
            { params: query },
        )

        return response.data
    }

    async Create(body: Service.Parameters.Create): Promise<Service.Responses.Full> {
        const response = await this.client.post(
            Paths.Create, 
            body
        )

        return response.data;
    }

    async Retrieve(id: UUID, query: Service.Parameters.RetrieveFull): Promise<Service.Responses.Full> {
        const response = await this.client.get(
            Paths.Retrieve.replace("(id)", id.uuid),
            { params: query },
        )

        return response.data
    }

    async Update(id: UUID, body: Service.Parameters.Patch): Promise<Service.Responses.Full> {
        const response = await this.client.put(
            Paths.Update.replace("(id)", id.uuid),
            body
        )

        return response.data
    }

    async Delete(id: UUID): Promise<Int> {
        const response = await this.client.delete(
            Paths.Delete.replace("(id)", id.uuid),
        )

        return new Int(response.status)
    }
}