import { UUID } from "../tsPrimitives/UUID";

export enum Types {
    PROCEDURE = "procedure",
    COMPLEX = "complex",
}

export class AppointmentType {
    type: Types
    id: UUID

    constructor(type: Types, id: UUID) {
        this.type = type
        this.id = id
    }

    toJSON() {
        return {
            [this.type]: {
                id: this.id
            }
        }
    }

    static fromJSON(json: any): AppointmentType {
        const type = Object.keys(json).find(key => Object.values(Types).find(value => value === key));
        if (!type) {
            throw new Error('Invalid JSON: no type found');
        }
        const id = json[type].id;

        return new AppointmentType(type as Types, id);
    }
}