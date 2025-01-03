import { client } from "../clientFactory/Client";
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { UUID } from "../../dto/tsPrimitives/UUID";
import { Int } from "../../dto/tsPrimitives/Int";
import { Position } from "../../dto/objects/Position";
import { Procedure } from "../../dto/objects/Procedure";
import { CookieStorage, TestStorage } from "../clientFactory/Storage";

const Paths = {
    Create:   "procedures",
    All:      "procedures",
    Retrieve: "procedures/(id)",
    Update:   "procedures/(id)",
    Delete:   "procedures/(id)",
}

export class ProcedureService {
    private client: AxiosInstance

    constructor() { 
        this.client = client(process.env.NODE_ENV === 'production' ? 
            new CookieStorage(cookies()) : 
            new TestStorage()
        );
    }

    async Create(body: Procedure.Parameters.Create): Promise<Procedure.Responses.Full> {
        const response = await this.client.post(
            Paths.Create,
            body
        )

        return response.data;
    }

    async All(query: Procedure.Parameters.Retrieve): Promise<Position.Responses.Partial[]> {
        const response = await this.client.get(
            Paths.All, 
            { params: { query } }
        )

        return response.data;
    }

    async Retrieve(id: UUID): Promise<Procedure.Responses.Full> {
        const response = await this.client.get(
            Paths.Retrieve.replace("(id)", id.uuid)
        )

        return response.data;
    }

    async Update(id: UUID, body: Procedure.Parameters.Patch): Promise<Procedure.Responses.Full> {
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