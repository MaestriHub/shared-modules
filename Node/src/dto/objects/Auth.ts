import { Token } from "../primitives/Token"

export namespace Auth {

    export namespace Parameters {

        export interface AppleToken {
            token: string
            firstName: string | undefined
            lastName: string | undefined
            email: string | undefined
            emailVerified: boolean | undefined
        }
        
        export class GoogleToken {
            token: string
            firstName: string | undefined
            lastName: string | undefined
        }
    }
    
    export namespace Responses {
    
        export class Full {
            accessToken: Token
            refreshToken: Token
            //user:
        }
        
        export class Partial {
            accessToken: Token
            refreshToken: Token | undefined
        }
    }    
}