import { client } from "../clientFactory/Client";
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { Statistic } from "../../dto/objects/Statistic"

const Paths = {
    Appointments: "statistics/appointments",
}

export class StatisticService {
    private client: AxiosInstance

    constructor() { 
        this.client = client(process.env.NODE_ENV === 'production' ? cookies() : new Map());
    }

    async Appointments(query: Statistic.Parameters.AppointmentsQuery ): Promise<Statistic.Responses.Appointments> {
        const response = await this.client.get(
            Paths.Appointments,
            { params: query },
        )

        return response.data
    }
}