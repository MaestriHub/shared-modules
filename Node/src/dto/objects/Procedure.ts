import { ValidateNested } from "class-validator"
import { Price } from "../primitives/Price"
import { Int } from "../tsPrimitives/Int"
import { UUID } from "../tsPrimitives/UUID"
import { Service } from "./Service"
import { Employee } from "./Employee"

export namespace Procedure {
    
    export namespace Parameters {
        
        export class Retrieve {
            @ValidateNested()
            salons?: UUID[]

            @ValidateNested()
            employees?: UUID[]

            constructor(
                salons?: UUID[],
                employees?: UUID[]
            ) {
                this.salons = salons
                this.employees = employees
            }
        }

        export class Create {
            description?: string
            alias?: string

            @ValidateNested()
            price: Price

            @ValidateNested()
            duration: Int

            @ValidateNested()
            serviceId: UUID

            @ValidateNested()
            employeeId: UUID

            constructor(
                price: Price,
                duration: Int,
                serviceId: UUID,
                employeeId: UUID,
                description?: string,
                alias?: string,
            ) {
                this.price = price
                this.duration = duration
                this.description = description
                this.alias = alias
                this.serviceId = serviceId
                this.employeeId = employeeId
            }
        }

        export class Patch {
            description?: string
            alias?: string

            @ValidateNested()
            price?: Price

            @ValidateNested()
            duration?: Int

            constructor(
                price?: Price,
                duration?: Int,
                description?: string,
                alias?: string
            ) {
                this.price = price
                this.duration = duration
                this.description = description
                this.alias = alias
            }
        }
    }
    
    export namespace Responses {
    
        export class Full {
            description?: string
            alias?: string

            @ValidateNested()
            id: UUID

            @ValidateNested()
            price: Price

            @ValidateNested()
            duration: Int
            
            @ValidateNested()
            service: Service.Responses.Micro

            @ValidateNested()
            master: Employee.Responses.Partial

            constructor(
                id: UUID,
                price: Price,
                duration: Int,
                service: Service.Responses.Micro,
                master: Employee.Responses.Partial,
                description?: string,
                alias?: string,
            ) {
                this.id = id
                this.price = price
                this.duration = duration
                this.description = description
                this.alias = alias
                this.service = service
                this.master = master
            }
        }

        export class Partial {
            description?: string
            alias?: string

            @ValidateNested()
            id: UUID

            @ValidateNested()
            price: Price

            @ValidateNested()
            duration: Int
            
            @ValidateNested()
            service: Service.Responses.Micro

            @ValidateNested()
            master: Employee.Responses.Partial

            constructor(
                id: UUID,
                price: Price,
                duration: Int,
                service: Service.Responses.Micro,
                master: Employee.Responses.Partial,
                description?: string,
                alias?: string,
            ) {
                this.id = id
                this.price = price
                this.duration = duration
                this.description = description
                this.alias = alias
                this.service = service
                this.master = master
            }
        }
    }
}