import { Customer } from "../objects/Customer"

type Success = Customer.Responses.Full
type Request = Customer.Responses.Verify

export enum Types {
    Success = "success",
    Request = "request",
}

export class HandleInvite {
    type: Types
    invite: Success | Request

    constructor(type: Types, invite: Success | Request) {
        this.type = type
        this.invite = invite
    }

    //TODO: проверить
    toJSON() {
        let key: string
        switch (this.type) {
            case Types.Request:
                key = "verify"
            case Types.Success:
                key = "customer"
        }

        return {
            [this.type]: {
                [key]: this.invite
            }
        }
    }

    //TODO: проверить
    static fromJSON(json: any): HandleInvite {
        const type = Object.keys(json).find(key => Object.values(Types).find(value => value === key));
        if (!type) {
            throw new Error('Invalid JSON: no type found');
        }
        const invite = json[type].invite;

        return new HandleInvite(type as Types, invite);
    }
}