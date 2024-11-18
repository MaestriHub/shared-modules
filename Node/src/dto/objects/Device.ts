import { VersionType } from "../enums/VersionType"
import { SystemType } from "../enums/SystemType"
import { UUID } from "../tsPrimitives/UUID"
import { ValidateNested } from "class-validator"


export namespace Device {

    export namespace Parameters {

        export class System {
            manufacturer?: string
            model?: string
            system?: SystemType
            appVersion?: string
            country?: string
            fcmToken?: string

            constructor (
                manufacturer?: string, 
                model?: string, 
                system?: SystemType, 
                appVersion?: string, 
                country?: string, 
                fcmToken?: string
            ) {
                this.manufacturer = manufacturer
                this.model = model
                this.system = system
                this.appVersion = appVersion
                this.country = country
                this.fcmToken = fcmToken
            }
        }
    }

    export namespace Responses {

        export class Full {
            @ValidateNested()
            id: UUID
            
            version?: VersionType

            constructor(
                id: UUID, 
                version?: VersionType
            ) {
                this.id = id
                this.version = version
            }
        }
    }
}