import { IsUUID, isUUID } from "class-validator"
import { v4 as uuidv4 } from 'uuid';

export class UUID {
    
    @IsUUID()
    uuid: string

    constructor(uuid: string = uuidv4()) {
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