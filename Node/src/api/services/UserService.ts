import { client } from "../clientFactory/Client";
import { User } from "../../dto/objects/User";
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { Professional } from "../../dto/objects/Professional";
import { Int } from "../../dto/tsPrimitives/Int";
import { CookieStorage, TestStorage } from "../clientFactory/Storage";

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
        this.client = client(process.env.NODE_ENV === 'production' ? 
            new CookieStorage(cookies()) : 
            new TestStorage()
        );
    }

    async CreateProfessional(body: Professional.Parameters.Create): Promise<User.Responses.Full> {
        const response = await this.client.post(
            Paths.CreateProfessional, 
            body,
            { headers: { "Requester-Type": "user" } },
        )

        return response.data;
    }

  // ❌ Depreceted for WEB
  // async CreateCustomer(body: Customer.Parameters.Create): Promise<User.Responses.Full> {
  //   const response = await this.client.post(Paths.CreateCustomer, body)

  //   return response.data;
  // }
  
    async GetUser(): Promise<User.Responses.Full> {
        const response = await this.client.get(
            Paths.GetUser,
            { headers: { "Requester-Type": "user" } },
        )

        return response.data;
    }

    async UpdateUser(body: User.Parameters.Patch): Promise<User.Responses.Full> {
        const response = await this.client.put(
            Paths.UpdateUser, 
            body,
            { headers: { "Requester-Type": "user" } },
        )

        return response.data;
    }

    async DeleteUser(): Promise<Int> {
        const response = await this.client.delete(
            Paths.DeleteUser,
            { headers: { "Requester-Type": "user" } },
        )

        return new Int(response.status)
    }
}