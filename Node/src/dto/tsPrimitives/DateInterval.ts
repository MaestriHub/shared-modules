import { IsPositive } from "class-validator";

export class DateInterval {
    @IsPositive()
    duration: number;

    start: Date;
}