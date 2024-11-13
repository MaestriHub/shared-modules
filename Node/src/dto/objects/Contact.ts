import { ContactType } from "../enums/ContactType"

interface Contact {

    Parameters: {
    
        Create: {
            value: string
            type: ContactType
            isVerify: boolean | undefined
        }

        SendCode: {
            recaptchaToken: string | undefined
        }

        Verify: {
            code: string
        }
    }// TODO: | undefined

    Responses: {

        Full: {
            id: string, // TODO: UUID представлено как строка??
            value: string,
            isVerify: boolean,
            type: ContactType,
        }

        Verify: {
            isVerified: boolean
        }
    } // TODO: | undefined
}