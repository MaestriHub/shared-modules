import { IsPositive } from "class-validator";
import { IsoDate } from "./IsoDate";

export class DateInterval {
    @IsPositive()
    duration: number;

    start: IsoDate;

    constructor(
        duration: number,
        start: IsoDate
    ) {
        this.duration = duration;
        this.start = start;
    }
}