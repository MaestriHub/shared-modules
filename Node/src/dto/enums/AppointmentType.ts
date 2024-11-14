type AppointmentType = ProcedureType | ComplexType

interface ProcedureType {
    type: "procedure"
    id: string
}

interface ComplexType {
    type: "complex"
    id: string
} 