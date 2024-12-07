import { User } from "../objects/User";
import { ValidateNested } from "class-validator";

export type CustomerUser = CustomerUser.Link   | 
                           CustomerUser.Value

export namespace CustomerUser {

    export class Link {
        link: URL

        constructor(link: URL) {
            this.link = link
        }
    }

    export class Value {
        @ValidateNested()
        value: User.Responses.Partial

        constructor(value: User.Responses.Partial) {
            this.value = value
        }
    }
}