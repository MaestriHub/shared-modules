import { client } from "../clientFactory/Client";
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { UUID } from "../../dto/tsPrimitives/UUID";
import { Int } from "../../dto/tsPrimitives/Int";
import { Contact } from "../../dto/objects/Contact";

const Paths = {
    RetrieveCustomer:  "contacts/customer/(customerId)",
    CreateForCustomer: "contacts/customer/(customerId)",
    DeleteForCustomer: "contacs/customer/(customerId)/(contactId)",
    RetrieveEmployee:  "contacts/employee/(employeeId)",
    CreateForEmployee: "contacts/employee/(employeeId)",
    DeleteForEmployee: "contacs/employee/(employeeId)/(contactId)",
}

export class ContactService {
    private client: AxiosInstance

    constructor() { 
        this.client = client(process.env.NODE_ENV === 'production' ? cookies() : new Map());
    }

    async RetrieveCustomer(customerId: UUID): Promise<Contact.Responses.Full[]> {
        const response = await this.client.get(
            Paths.RetrieveCustomer.replace("(customerId)", customerId.uuid)
        );

        return response.data;
    }

    async RetrieveEmployee(employeeId: UUID): Promise<Contact.Responses.Full[]> {
        const response = await this.client.get(
            Paths.RetrieveEmployee.replace("(employeeId)", employeeId.uuid)
        );

        return response.data;
    }

    async CreateForCustomer(customerId: UUID, body: Contact.Parameters.Create) : Promise<Contact.Responses.Full> {
        const response = await this.client.post(
            Paths.CreateForCustomer.replace("(customerId)", customerId.uuid), 
            body
        );

        return response.data;
    }

    async CreateForEmployee(employeeId: UUID, body: Contact.Parameters.Create) : Promise<Contact.Responses.Full> {
        const response = await this.client.post(
            Paths.CreateForCustomer.replace("(customerId)", employeeId.uuid), 
            body
        );

        return response.data;
    }

    async DeleteForCustomer(customerId: UUID, contactId: UUID): Promise<Int> {
        const response = await this.client.delete(
            Paths.DeleteForCustomer
                .replace("(customerId)", customerId.uuid)
                .replace("(contactId)", contactId.uuid)
        );

        return new Int(response.status)
    }  

    async DeleteForEmployee(employeeId: UUID, contactId: UUID): Promise<Int> {
        const response = await this.client.delete(
            Paths.DeleteForEmployee
                .replace("(employeeId)", employeeId.uuid)
                .replace("(contactId)", contactId.uuid)
        );

        return new Int(response.status)
    }
}