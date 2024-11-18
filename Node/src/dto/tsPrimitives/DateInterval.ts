import { IsPositive } from "class-validator";

export class DateInterval {
    @IsPositive()
    duration: number;

    start: Date;

    constructor(
        duration: number,
        start: Date
    ) {
        this.duration = duration;
        this.start = start;
    }
}