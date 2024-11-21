import { formatRFC3339 } from "date-fns"

export class IsoDate {
    private date: Date

    constructor(date: Date = new Date()) {
        this.date = date
    }

    toJSON() {
        return formatRFC3339(this.date)
    }

    fromJSON(json: any): IsoDate {
        return new IsoDate(new Date(json))
    }
}