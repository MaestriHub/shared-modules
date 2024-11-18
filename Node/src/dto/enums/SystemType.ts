export enum Types {
    IOS = "ios",
    ANDROID = "android",
    CHROME = "chrome",
    EDGE = "edge",
    FIREFOX = "firefox",
    OPERA = "opera",
    SAFARI = "safari",
}

export class SystemType {
    type: Types
    version: string

    constructor(type: Types, version: string) {
        this.type = type
        this.version = version
    }

    toJSON() {
        return {
            [this.type]: {
                version: this.version
            }
        }
    }

    static fromJSON(json: any): SystemType {
        const type = Object.keys(json).find(key => Object.values(Types).find(value => value === key));
        if (!type) {
            throw new Error('Invalid JSON: no type found');
        }
        const version = json[type].version;

        return new SystemType(type as Types, version);
    }
}