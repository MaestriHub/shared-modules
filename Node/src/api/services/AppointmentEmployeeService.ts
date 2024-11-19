import { client } from "../clientFactory/Client";
import { User } from "../../dto/objects/User";
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { UUID } from "../../dto/tsPrimitives/UUID";
import { Int } from "../../dto/tsPrimitives/Int";
import { AppointmentEmployee } from "../../dto/objects/AppointmentEmployee";

enum Paths {
  History = "appointment/employee/history",
  Create = "appointment/employee",
  Retrieve = "appointment/employee/(id)",
  Approve = "appointment/employee/approve",
  Update = "appointment/employee/(id)",
  Reject = "appointment/employee/(id)/reject",
}

export class AppointmentEmployeeService {
  private client: AxiosInstance

  constructor() { 
    this.client = client(process.env.NODE_ENV === 'production' ? cookies() : new Map());
  }

  async History(query: AppointmentEmployee.Parameters.Retrieve): Promise<AppointmentEmployee.Responses.Partial[]> {
    const response = await this.client.get(Paths.History, { params: query })

    return response.data;
  }

  async Create(body: AppointmentEmployee.Parameters.Create): Promise<AppointmentEmployee.Responses.Full> {
    const response = await this.client.post(Paths.Create, body)

    return response.data;
  }

  async Retrieve(id: UUID): Promise<AppointmentEmployee.Responses.Full> {
    const response = await this.client.get(Paths.Retrieve.replace("(id)", id.uuid))

    return response.data;
  }

  async Approve(body: AppointmentEmployee.Parameters.Approve): Promise<AppointmentEmployee.Responses.Full> {
    const response = await this.client.patch(Paths.Approve, body)

    return response.data
  }

  async Reject(id: UUID): Promise<Int> {
    const response = await this.client.patch(Paths.Reject.replace("(id)", id.uuid))

    return new Int(response.status)
  }

  async Update(id: UUID, body: AppointmentEmployee.Parameters.Patch): Promise<User.Responses.Full> {
    const response = await this.client.put(Paths.Update.replace("(id)", id.uuid), body)

    return response.data;
  }
}