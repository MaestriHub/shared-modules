export class SystemType {
    type: SystemType.Types

    constructor(type: SystemType.Types) {
        this.type = type
    }
    
    toJSON() {
        switch (true) {
        case this.type instanceof SystemType.Ios:
            return {
                ios: this.type
            }
        case this.type instanceof SystemType.Android:
            return {
                android: this.type
            }
        case this.type instanceof SystemType.Chrome:
            return {
                chrome: this.type
            }
        case this.type instanceof SystemType.Edge:
            return {
                edge: this.type
            }
        case this.type instanceof SystemType.Firefox:
            return {
                firefox: this.type
            }
        case this.type instanceof SystemType.Opera:
            return {
                opera: this.type
            }
        case this.type instanceof SystemType.Safari:
            return {
                safari: this.type
            }
        }
    }

    static fromJSON(json: any): SystemType {
        if (json.ios) {
            return new SystemType(json.ios);
        } else if (json.android) {
            return new SystemType(json.android);
        } else if (json.chrome) {
            return new SystemType(json.chrome);
        } else if (json.edge) {
            return new SystemType(json.edge);
        } else if (json.firefox) {
            return new SystemType(json.firefox);
        } else if (json.opera) {
            return new SystemType(json.opera);
        } else if (json.safari) {
            return new SystemType(json.safari);
        } else {
            throw new Error("Unknown Schedule pattern type");
        }
    }
}

export namespace SystemType {

    export type Types = SystemType.Ios     | 
                        SystemType.Android |
                        SystemType.Edge    |
                        SystemType.Chrome  |
                        SystemType.Opera   |
                        SystemType.Firefox |
                        SystemType.Safari

    export class Ios {
        version: string

        constructor(version: string) {
            this.version = version
        }
    }

    export class Android {
        version: string

        constructor(version: string) {
            this.version = version
        }
    }

    export class Chrome {
        version: string

        constructor(version: string) {
            this.version = version
        }
    }

    export class Edge {
        version: string

        constructor(version: string) {
            this.version = version
        }
    }

    export class Firefox {
        version: string

        constructor(version: string) {
            this.version = version
        }
    }

    export class Opera {
        version: string

        constructor(version: string) {
            this.version = version
        }
    }

    export class Safari {
        version: string

        constructor(version: string) {
            this.version = version
        }
    }
}