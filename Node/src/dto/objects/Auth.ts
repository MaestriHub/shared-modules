import { IsEmail, ValidateNested } from "class-validator"
import { Token } from "../primitives/Token"
import { User } from "./User"

export namespace Auth {

    export namespace Parameters {

        export class AppleToken {
            token: string
            firstName?: string
            lastName?: string
            emailVerified?: boolean

            @IsEmail()
            email?: string

            constructor(
                token: string, 
                firstName?: string, 
                lastName?: string, 
                email?: string, 
                emailVerified?: boolean
            ) {
                this.token = token
                this.firstName = firstName
                this.lastName = lastName
                this.email = email
                this.emailVerified = emailVerified
            }
        }
        
        export class GoogleToken {
            token: string
            firstName?: string
            lastName?: string

            constructor(
                token: string, 
                firstName?: string, 
                lastName?: string, 
            ) {
                this.token = token
                this.firstName = firstName
                this.lastName = lastName
            }
        }
    }
    
    export namespace Responses {
    
        export class Full {
            accessToken: Token
            refreshToken: Token

            @ValidateNested()
            user: User.Responses.Full

            constructor(
                accessToken: Token, 
                refreshToken: Token,
                user: User.Responses.Full
            ) { 
                this.accessToken = accessToken
                this.refreshToken = refreshToken
                this.user = user
            }
        }
        
        export class Partial {
            accessToken: Token
            refreshToken?: Token

            constructor(
                accessToken: Token, 
                refreshToken?: Token
            ) { 
                this.accessToken = accessToken
                this.refreshToken = refreshToken
            }
        }
    }    
}