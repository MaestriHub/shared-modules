import { Professional } from "../objects/Professional";
import { ValidateNested } from "class-validator";

export type ProfessionalEmployee = ProfessionalEmployee.Link   | 
                                   ProfessionalEmployee.Value

export namespace ProfessionalEmployee {

    export class Link {
        link: URL

        constructor(link: URL) {
            this.link = link
        }
    }

    export class Value {
        @ValidateNested()
        value: Professional.Responses.Partial

        constructor(value: Professional.Responses.Partial) {
            this.value = value
        }
    }
}