import { UUID } from "../tsPrimitives/UUID";
import { ValidateNested } from "class-validator";

export class AppointmentType {
    type: AppointmentType.Types

    constructor(type: AppointmentType.Types) {
        this.type = type
    }

    toJSON() {
        switch (true) {
        case this.type instanceof AppointmentType.Procedure:
            return {
                procedure: this.type
            }
        case this.type instanceof AppointmentType.Complex:
            return {
                complex: this.type
            }
        }
    }

    static fromJSON(json: any): AppointmentType {
        if (json.complex) {
            return new AppointmentType(json.complex);
        } else if (json.procedure) {
            return new AppointmentType(json.procedure);
        } else {
            throw new Error("Unknown Schedule pattern type");
        }
    }
}

export namespace AppointmentType {

    export type Types = AppointmentType.Complex   | 
                        AppointmentType.Procedure

    export class Procedure {
        @ValidateNested()
        id: UUID

        constructor(id: UUID) {
            this.id = id
        }
    }

    export class Complex {
        @ValidateNested()
        id: UUID

        constructor(id: UUID) {
            this.id = id
        }
    }
}