type Link = URL
type Value = Professional.Responses.Partial

export enum Types {
    LINK = "link",
    VALUE = "value",
}

// TODO:
export class ProfessionalEmployee {
    type: Types
    employee: Value | Link

    constructor(type: Types, employee: Value | Link) {
        this.type = type
        this.employee = this.employee
    }

    //TODO: проверить
    toJSON() {
        let key: string
        switch (this.type) {
            case Types.LINK:
                key = "url"
            case Types.VALUE:
                key = "user"
        }

        return {
            [this.type]: {
                [key]: this.employee
            }
        }
    }

    //TODO: проверить!!!
    static fromJSON(json: any): ProfessionalEmployee {
        const type = Object.keys(json).find(key => Object.values(Types).find(value => value === key));
        if (!type) {
            throw new Error('Invalid JSON: no type found');
        }
        const employee = json[type].employee;

        return new ProfessionalEmployee(type as Types, employee);
    }
}