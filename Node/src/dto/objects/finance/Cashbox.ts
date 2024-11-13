import { PaymentType } from "../../enums/PaymentType"

export interface Cashbox {

    Parameters: {

        Create: {
            salonId: string, // TODO: UUID представлено как строка??
            paymentType: PaymentType,
        }

        Retrieve: {
            paymentType: PaymentType | undefined,
            startDate: Date | undefined,
            endDate: Date | undefined,
        }
    }

    Responses: {

        Full: {
            id: string, // TODO: UUID представлено как строка??
            createDate: Date,
            paymentType: PaymentType,
        }
    }
}