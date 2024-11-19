import { client } from "../clientFactory/Client";
import { User } from "../../dto/objects/User";
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { UUID } from "../../dto/tsPrimitives/UUID";
import { Professional } from "../../dto/objects/Professional";
import { Int } from "../../dto/tsPrimitives/Int";

const Paths = {
    CreateProfessional: "users/professional",
    CreateCustomer:     "users/customer",
    GetUser:            "users",
    UpdateUser:         "users",
    DeleteUser:         "users",
}

export class UserService {
    private client: AxiosInstance

    constructor() { 
        this.client = client(process.env.NODE_ENV === 'production' ? cookies() : new Map());
    }

    async CreateProfessional(body: Professional.Parameters.Create): Promise<User.Responses.Full> {
        const response = await this.client.post(Paths.CreateProfessional, body)

        return response.data;
    }

  // ❌ Depreceted for WEB
  // async CreateCustomer(body: Customer.Parameters.Create): Promise<User.Responses.Full> {
  //   const response = await this.client.post(Paths.CreateCustomer, body)

  //   return response.data;
  // }

    async GetUser(id: UUID): Promise<User.Responses.Full> {
        const response = await this.client.get(Paths.GetUser)

        return response.data;
    }

    async UpdateUser(body: User.Parameters.Patch): Promise<User.Responses.Full> {
        const response = await this.client.put(Paths.UpdateUser, body)

        return response.data;
    }

    async DeleteUser(): Promise<Int> {
        const response = await this.client.delete(Paths.DeleteUser)

        return new Int(response.status)
    }
}