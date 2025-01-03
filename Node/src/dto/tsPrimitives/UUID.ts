import { IsDefined, IsUUID, isUUID } from "class-validator"
import {  v4 as uuidv4 } from 'uuid';

export class UUID {
    
    @IsUUID()
    @IsDefined()
    uuid: string

    constructor(uuid: string = uuidv4()) {
        this.uuid = uuid
    }

    public toJSON() {
        return this.uuid
    }

    public static fromJSON(json: any): UUID {
        if (!isUUID(json)) {
            throw new Error("Invalid UUID")
        }
        return new UUID(json)
    }
}