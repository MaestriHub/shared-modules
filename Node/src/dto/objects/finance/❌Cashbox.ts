// MARK: NEED BRAINSTORM

//import { PaymentType } from "../../enums/PaymentType"
//
//export namespace Cashbox {
//
//    export namespace Parameters {
//
//        export class Create {
//            salonId: string // TODO: UUID представлено как строка??
//            paymentType: PaymentType
//
//            constructor(
//                salonId: string, 
//                paymentType: PaymentType
//            ) {
//                this.salonId = salonId
//                this.paymentType = paymentType
//            }
//        }
//
//        export class Retrieve {
//            paymentType?: PaymentType
//            startDate?: Date
//            endDate?: Date
//
//            constructor(
//                paymentType?: PaymentType,
//                startDate?: Date,
//                endDate?: Date
//            ) {
//                this.paymentType = paymentType
//                this.startDate = startDate
//                this.endDate = endDate
//            }
//        }
//    }
//
//    export namespace Responses {
//        export class Full {
//            id: string // TODO: UUID представлено как строка??
//            createDate: Date
//            paymentType: PaymentType
//
//            constructor(
//                id: string, // TODO: UUID представлено как строка??
//                createDate: Date,
//                paymentType: PaymentType
//            ) {
//                this.id = id
//                this.createDate = createDate
//                this.paymentType = paymentType
//            }
//        }
//    }
//}
