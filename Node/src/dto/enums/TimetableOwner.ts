import { UUID } from "../tsPrimitives/UUID"
import { ValidateNested } from "class-validator";

export class TimetableOwner {
    type: TimetableOwner.Types

    constructor(type: TimetableOwner.Types) {
        this.type = type
    }

    toJSON() {
        switch (true) {
        case this.type instanceof TimetableOwner.Salon:
            return "salon:" + this.type.id
        case this.type instanceof TimetableOwner.Employee:
            return "employee:" + this.type.id
        }
    }

    static fromJSON(json: any): TimetableOwner {
        const [type, id] = json.split(":");
        switch (type) {
        case "salon":
            return new TimetableOwner(new TimetableOwner.Salon(id));
        case "employee":
            return new TimetableOwner(new TimetableOwner.Employee(id));
        default:
            throw new Error("Unknown type");
        }
    }
}

export namespace TimetableOwner {

    export type Types = TimetableOwner.Employee | 
                        TimetableOwner.Salon

    export class Salon {
        @ValidateNested()
        id: UUID

        constructor(id: UUID) {
            this.id = id
        }
    }

    export class Employee {
        @ValidateNested()
        id: UUID 

        constructor(id: UUID) {
            this.id = id
        }
    }
}