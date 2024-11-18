import { PermissionSet } from "../optionSet/PermissionSet"
import {  Salary } from "./Salary"
import { UUID } from "../tsPrimitives/UUID"
import { ValidateNested } from "class-validator"

export namespace Position {

    export namespace Parameters {
        
        export class Create {
            title: string
            permissions: PermissionSet

            @ValidateNested()
            salary: Salary.Parameters.Rules.Create

            constructor (
                title: string,
                permissions: PermissionSet,
                salary: Salary.Parameters.Rules.Create
            ) {
                this.title = title
                this.permissions = permissions
                this.salary = salary
            }
        }

        export class Patch {
            title?: string
            permissions?: PermissionSet

            @ValidateNested()
            salary?: Salary.Parameters.Rules.Create

            constructor (
                title?: string,
                permissions?: PermissionSet,
                salary?: Salary.Parameters.Rules.Create
            ) {
                this.title = title
                this.permissions = permissions
                this.salary = salary
            }
        }
    }

    export namespace Responses {
        
        export class Full {
            @ValidateNested()
            id: UUID

            title: string
            permissions: PermissionSet

            @ValidateNested()
            salary: Salary.Responses.Rules.Full

            constructor (
                id: UUID,
                title: string,
                permissions: PermissionSet,
                salary: Salary.Responses.Rules.Full
            ) {
                this.id = id
                this.title = title
                this.permissions = permissions
                this.salary = salary
            }
        }

        export class Partial {
            @ValidateNested()
            id: UUID
            
            title: string

            constructor (
                id: UUID,
                title: string
            ) {
                this.id = id
                this.title = title
            }
        }
    }
}