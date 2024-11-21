import { User } from "../objects/User";
import { ValidateNested } from "class-validator";

export class CustomerUser {
    type: CustomerUser.Types

    constructor(type: CustomerUser.Types) {
        this.type = type
    }

    toJSON() {
        switch (true) {
        case this.type instanceof CustomerUser.Link:
            return {
                link: this.type
            }
        case this.type instanceof CustomerUser.Value:
            return {
                value: this.type
            }
        }
    }

    static fromJSON(json: any): CustomerUser {
        if (json.link) {
            return new CustomerUser(json.link);
        } else if (json.value) {
            return new CustomerUser(json.value);
        } else {
            throw new Error("Unknown Schedule pattern type");
        }
    }
}

export namespace CustomerUser {

    export type Types = CustomerUser.Link  | 
                        CustomerUser.Value

    export class Link {
        @ValidateNested()
        url: URL

        constructor(url: URL) {
            this.url = url
        }
    }

    export class Value {
        @ValidateNested()
        customer: User.Responses.Partial

        constructor(customer: User.Responses.Partial) {
            this.customer = customer
        }
    }
}