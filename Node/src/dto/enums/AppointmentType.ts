import { UUID } from "../tsPrimitives/UUID";
import { ValidateNested } from "class-validator";

export type AppointmentType = AppointmentType.Complex   | 
                              AppointmentType.Procedure

export namespace AppointmentType {

    export class Procedure {
        @ValidateNested()
        procedure: UUID

        constructor(id: UUID) {
            this.procedure = id
        }
    }

    export class Complex {
        @ValidateNested()
        complex: UUID

        constructor(id: UUID) {
            this.complex = id
        }
    }
}