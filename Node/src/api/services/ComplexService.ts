import { client } from "../clientFactory/Client";
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { UUID } from "../../dto/tsPrimitives/UUID";
import { Int } from "../../dto/tsPrimitives/Int";
import { Complex } from "../../dto/objects/Complex";
import { CookieStorage, TestStorage } from "../clientFactory/Storage";

const Paths = {
    All:      "complex",
    Create:   "complex",
    Retrieve: "complex/(id)",
    Update:   "complex/(id)",
    Delete:   "compex/(id)",
}

export class ComplexService {
    private client: AxiosInstance

    constructor() { 
        this.client = client(process.env.NODE_ENV === 'production' ? 
            new CookieStorage(cookies()) : 
            new TestStorage()
        );
    }

    async All(query: Complex.Parameters.Retrieve): Promise<Complex.Responses.Partial[]> {
        const response = await this.client.get(
            Paths.All, 
            { params: query }
        )

        return response.data;
    }

    async Create(body: Complex.Parameters.Create): Promise<Complex.Responses.Full> {
        const response = await this.client.post(
            Paths.Create, 
            body
        )

        return response.data;
    }

    async Update(id: UUID, body: Complex.Parameters.Patch): Promise<Complex.Responses.Full> {
        const response = await this.client.put(
            Paths.Update.replace("(id)", id.uuid), 
            body
        )

        return response.data;
    }

    async Retrieve(id: UUID): Promise<Complex.Responses.Full> {
        const response = await this.client.get(
            Paths.Retrieve.replace("(id)", id.uuid)
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