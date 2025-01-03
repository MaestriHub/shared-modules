import { IsoDate } from "../tsPrimitives/IsoDate"

export interface Token {
    value: string
    expiration: IsoDate
}