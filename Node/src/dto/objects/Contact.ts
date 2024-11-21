import { ValidateNested } from "class-validator"
import { ContactType } from "../enums/ContactType"
import { UUID } from "../tsPrimitives/UUID"

export namespace Contact {

    export namespace Parameters {

        export class Create {
            value: string
            type: ContactType
            isVerify?: boolean

            constructor(
                value: string, 
                type: ContactType, 
                isVerify?: boolean
            ) {
                this.value = value
                this.type = type
                this.isVerify = isVerify
            }
        }

        export class SendCode {
            recaptchaToken?: string

            constructor(
                recaptchaToken?: string
            ) {
                this.recaptchaToken = recaptchaToken
            }
        }

        export class Verify {
            code: string

            constructor(
                code: string
            ) {
                this.code = code
            }
        }
    }

    export namespace Responses {
        
        export class Full {
            value: string
            isVerify: boolean
            type: ContactType

            @ValidateNested()
            id: UUID

            constructor(
                id: UUID, 
                value: string, 
                isVerify: boolean, 
                type: ContactType
            ) {
                this.id = id
                this.value = value
                this.isVerify = isVerify
                this.type = type
            }
        }

        export class Verified {
            isVerified: boolean

            constructor(
                isVerified: boolean
            ) {
                this.isVerified = isVerified
            }
        }
    }
}