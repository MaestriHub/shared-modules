import { NoticeCategory } from "../enums/NoticeCategory"

export interface Notice {
    Full: {
        id: string, // TODO: UUID представлено как строка??
        titleKey: string,
        messageKey: string,
        parameters: string | undefined,
        category: NoticeCategory,
        isRead: boolean,
        date: Date | undefined,
    }
}