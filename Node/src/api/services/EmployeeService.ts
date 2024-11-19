import { client } from "../clientFactory/Client";
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { UUID } from "../../dto/tsPrimitives/UUID";
import { Int } from "../../dto/tsPrimitives/Int";
import { Employee } from "../../dto/objects/Employee";
import { Salary } from "../../dto/objects/Salary";

enum Paths {
  All = "employees",
  Retrieve = "employees/(id)",
  Invite = "employees/invite",
  HandleInvite = "employees/(id)/handler",
  Update = "employees/(id)",
  Fire = "employees/(id)",
  Salary = "employees/(id)/salary",
}

export class EmployeeService {
  private client: AxiosInstance

  constructor() { 
    this.client = client(process.env.NODE_ENV === 'production' ? cookies() : new Map());
  }

  async All(query: Employee.Parameters.Retrieve): Promise<Employee.Responses.Partial[]> {
    const response = await this.client.get(Paths.All, { params: query })

    return response.data;
  }

  async Retrieve(id: UUID): Promise<Employee.Responses.Full> {
    const response = await this.client.get(Paths.Retrieve.replace("(id)", id.uuid))

    return response.data;
  }

  async Invite(body: Employee.Parameters.Invite): Promise<Employee.Responses.Full> {
    const response = await this.client.post(Paths.Invite, body)

    return response.data
  }

  async HandleInvite(id: UUID): Promise<Employee.Responses.Full> {
    const response = await this.client.put(Paths.HandleInvite.replace("(id)", id.uuid))

    return response.data
  }

  async Update(id: UUID, body: Employee.Parameters.Patch): Promise<Employee.Responses.Full> {
    const response = await this.client.put(Paths.Update.replace("(id)", id.uuid), body)

    return response.data
  }

  async Fire(id: UUID): Promise<Int> {
    const response = await this.client.delete(Paths.Fire.replace("(id)", id.uuid))

    return new Int(response.status)
  }

  async Salary(id: UUID, query: Salary.Parameters.Balance.Payout): Promise<Salary.Responses.Balance.Full> {
    const response = await this.client.get(
        Paths.Salary.replace("(id)", id.uuid), 
        { params: query }
    )

    return response.data
  }
}