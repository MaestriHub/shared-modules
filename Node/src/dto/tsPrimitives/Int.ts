import { isInt, IsInt } from "class-validator"

export class Int {
    
    @IsInt()
    private int: number

    constructor(value: number) {
        this.int = value
    }

    public toJSON() {
        return this.int
    }

    public static fromJSON(json: any): Int {
        if (!isInt(json)) {
            throw new Error("Invalid Int")
        }

        return new Int(Number(json))
    }
}