// Some Flow for use it 

// const appointmentType = AppointmentType.newProcedure("id");

// switch (appoitmentType.type) {
//     case AppointmentType.complexType:
//         break;
//     case AppointmentType.procedureType:
//         break;
// }

// export class AppointmentType {
//     type: string
//     id: string;

//     static complexType = "complex";
//     static procedureType = "procedure";

//     private constructor(type: string, id: string) {
//         this.type = type
//         this.id = id
//     }

//     static newComplex(id: string): AppointmentType {
//         return new AppointmentType(AppointmentType.complexType, id);
//     }

//     static newProcedure(id: string): AppointmentType {
//         return new AppointmentType(AppointmentType.procedureType, id);
//     }

//     toJSON(): { id: string, type: string } {
//         return { id: this.id, type: this.type };
//     }

//     static fromJson(json: { id: string, type: string }): AppointmentType {
//          return new AppointmentType(json.type, json.id);
//     }
// }

interface AppointmentType {
    type: Types
    id: string
} 

type Types = 'complex' | 'procedure';
// правильно ли я понимаю что я могу сделать так но ясно работать ты с этим не сможешь?

// type AppointmentType = 
//     | { type: "complex", id: string }
//     | { type: "procedure", id: string }