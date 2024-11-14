import { Price } from "../primitives/Price"

type TimetableOwner = Salon | Employee

interface Salon {
    type: "salon",
    id: string,
}

interface Employee {
    type: "employee",
    id: string,
}
