export enum Types {
    Salon = "salon",
    Employee = "employee",
}

export class TimetableOwner {
    type: Types
    id: string

    constructor(type: Types, id: string) {
        this.type = type
        this.id = id
    }

    toJSON() {
        return this.type + ":" + this.id
    }

    //TODO: явно не работает
    static fromJSON(json: any): TimetableOwner {
        const type = Object.keys(json).find(key => Object.values(Types).find(value => value === key));
        if (!type) {
            throw new Error('Invalid JSON: no type found');
        }
        const version = json[type].version;

        return new TimetableOwner(type as Types, version);
    }
}