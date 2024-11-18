import { User } from "./User"

export namespace Professional {

    export namespace Parameters {
        
        export class Create {
            constructor() {}
        }
    }

    export namespace Responses {
        
        export class Partial {
            user: User.Responses.Partial
            
            constructor(
                user: User.Responses.Partial
            ) {
                this.user = user
            }
        }
    }
}