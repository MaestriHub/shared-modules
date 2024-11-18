import { Token } from "../primitives/Token"

export namespace Auth {

    export namespace Parameters {

        export class AppleToken {
            token: string
            firstName?: string
            lastName?: string
            email?: string
            emailVerified?: boolean

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
            //user:

            constructor(
                accessToken: Token, 
                refreshToken: Token
            ) { 
                this.accessToken = accessToken
                this.refreshToken = refreshToken
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