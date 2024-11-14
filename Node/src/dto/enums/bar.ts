import { AppointmentType } from "./foo";

const foo = AppointmentType.newProcedure("id");

switch (foo.type) {
    case AppointmentType.complexType:
        break;
    case AppointmentType.procedureType:
        break;
}