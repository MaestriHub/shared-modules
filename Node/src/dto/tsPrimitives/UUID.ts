import { IsUUID, isUUID } from "class-validator"

export class UUID {
    
    @IsUUID()
    private uuid: string

    constructor(uuid: string) {
        this.uuid = uuid
    }

    public toJSON() {
        return this.uuid
    }

    public static fromJSON(uuid: string): UUID {
        if (!isUUID(uuid)) {
            throw new Error("Invalid UUID")
        }
        return new UUID(uuid)
    }
}