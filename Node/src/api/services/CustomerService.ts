import { client } from "../clientFactory/Client";
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { UUID } from "../../dto/tsPrimitives/UUID";
import { Customer } from "../../dto/objects/Customer";

enum Paths {
  All = "customers",
  Create = "customers",
  Retrieve = "customers/(id)",
  HandleInvite = "customers/(id)",
}

export class CustomerService {
  private client: AxiosInstance

  constructor() { 
    this.client = client(process.env.NODE_ENV === 'production' ? cookies() : new Map());
  }

  async All(query: Customer.Parameters.Retrieve): Promise<Customer.Responses.Partial[]> {
    const response = await this.client.get(Paths.All, { params: query })

    return response.data;
  }

  async Create(body: Customer.Parameters.Create): Promise<Customer.Responses.Full> {
    const response = await this.client.post(Paths.Create, body)

    return response.data;
  }

  async Retrieve(id: UUID): Promise<Customer.Responses.Full> {
    const response = await this.client.get(Paths.Retrieve.replace("(id)", id.uuid))

    return response.data;
  }

  async HandleInvite(id: UUID): Promise<Customer.Responses.Full> {
    const response = await this.client.put(Paths.HandleInvite.replace("(id)", id.uuid))

    return response.data;
  }
}