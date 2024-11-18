import { NoticeCategory } from "../enums/NoticeCategory"

export namespace Notice {
    
    export namespace Parameters {}

    export namespace Responses {        
        export class Full {
            id: string // TODO: UUID представлено как строка??
            titleKey: string
            messageKey: string
            parameters?: string
            category: NoticeCategory
            isRead: boolean
            date?: Date

            constructor(
                id: string, // TODO: UUID представлено как строка??
                titleKey: string,
                messageKey: string,
                category: NoticeCategory,
                isRead: boolean,
                parameters?: string,
                date?: Date,
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