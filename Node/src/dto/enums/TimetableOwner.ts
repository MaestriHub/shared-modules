type TimetableOwner = Salon | Employee

interface Salon {
    type: "salon",
    id: string,
}

interface Employee {
    type: "employee",
    id: string,
}
