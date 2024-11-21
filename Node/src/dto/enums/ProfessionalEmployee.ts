import { Professional } from "../objects/Professional";
import { ValidateNested } from "class-validator";

export class ProfessionalEmployee {
    type: ProfessionalEmployee.Types

    constructor(type: ProfessionalEmployee.Types) {
        this.type = type
    }

    toJSON() {
        switch (true) {
        case this.type instanceof ProfessionalEmployee.Link:
            return {
                link: this.type
            }
        case this.type instanceof ProfessionalEmployee.Value:
            return {
                value: this.type
            }
        }
    }

    static fromJSON(json: any): ProfessionalEmployee {
        if (json.link) {
            return new ProfessionalEmployee(json.link);
        } else if (json.value) {
            return new ProfessionalEmployee(json.value);
        } else {
            throw new Error("Unknown Schedule pattern type");
        }
    }
}

export namespace ProfessionalEmployee {

    export type Types = ProfessionalEmployee.Link | 
                        ProfessionalEmployee.Value

    export class Link {
        @ValidateNested()
        url: URL

        constructor(url: URL) {
            this.url = url
        }
    }

    export class Value {
        @ValidateNested()
        professional: Professional.Responses.Partial

        constructor(professional: Professional.Responses.Partial) {
            this.professional = professional
        }
    }
}