import { Max, Min } from "class-validator"

export class Address {
    address: string
    city: string
    country: string

    @Max(90)
    @Min(-90)
    latitude: number

    @Max(180)
    @Min(-180)
    longitude: number

    constructor(
        address: string,
        city: string,
        country: string,
        latitude: number,
        longitude: number
    ) {
        this.address = address
        this.city = city
        this.country = country
        this.latitude = latitude
        this.longitude = longitude
    }
}
