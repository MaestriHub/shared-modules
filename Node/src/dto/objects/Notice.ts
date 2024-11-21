import { ValidateNested } from "class-validator"
import { NoticeCategory } from "../enums/NoticeCategory"
import { UUID } from "../tsPrimitives/UUID"
import { IsoDate } from "../tsPrimitives/IsoDate"

export namespace Notice {
    
    export namespace Parameters {}

    export namespace Responses {        
        
        export class Full {
            @ValidateNested()
            id: UUID
            
            titleKey: string
            messageKey: string
            parameters?: string
            category: NoticeCategory
            isRead: boolean
            date?: IsoDate

            constructor(
                id: UUID,
                titleKey: string,
                messageKey: string,
                category: NoticeCategory,
                isRead: boolean,
                parameters?: string,
                date?: IsoDate,
            ) {
                this.id = id
                this.titleKey = titleKey
                this.messageKey = messageKey
                this.parameters = parameters
                this.category = category
                this.isRead = isRead
                this.date = date
            }
        }
    }
}