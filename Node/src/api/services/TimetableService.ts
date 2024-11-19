import { client } from "../clientFactory/Client";
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { TimetableOwner } from "../../dto/enums/TimetableOwner";
import { Int } from "../../dto/tsPrimitives/Int";
import { Timetable } from "../../dto/objects/Timetable";

const Paths = {
    Create:      "timetables/(owner)/(force)",
    SearchSlots: "timetables/search-slots",
    Schedules:   "timetables/schedules",
}

export class TimetableService {
    private client: AxiosInstance

    constructor() { 
        this.client = client(process.env.NODE_ENV === 'production' ? cookies() : new Map());
    }

    // forceChanging если установлено да то меняет расписание не смотря на appointments
    async Create(
        owner: TimetableOwner, 
        pattern: Timetable.Parameters.Create.Pattern, 
        forceChanging: boolean = false
    ): Promise<Int>{
        const response = await this.client.post(
            Paths.Create
                .replace("(owner)", JSON.stringify(owner))
                .replace("(force)", forceChanging.toString()),
            pattern
        )

        return new Int(response.status)
    }

    async SearchSlots(query: Timetable.Parameters.SearchSlot): Promise<Timetable.Responses.Slots> {
        const response = await this.client.get(
            Paths.SearchSlots,
            { params: query }
        )

        return response.data
    }

    async Schedules(query: Timetable.Parameters.Retrieve): Promise<Timetable.Responses.Schedule> {
        const response = await this.client.get(
            Paths.Schedules,
            { params: query }
        )

        return response.data
    }
}