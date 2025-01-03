// MARK: NEED BRAINSTORM
//import { PaymentType } from "../../enums/PaymentType"
//import { Price } from "../../primitives/Price"
//
//export namespace Operation {
//
//    export namespace Parameters {
//        export class Create {
//            price: Price
//            salonId: string // TODO: UUID представлено как строка??
//            paymentType: PaymentType
//            appointment?: AppointmentOperation
//            salary?: SalaryOperation
//            other?: OtherOperation
//
//            constructor(
//                price: Price,
//                salonId: string, // TODO: UUID представлено как строка??
//                paymentType: PaymentType,
//                appointment?: AppointmentOperation,
//                salary?: SalaryOperation,
//                other?: OtherOperation
//            ) {
//                this.price = price
//                this.salonId = salonId
//                this.paymentType = paymentType
//                this.appointment = appointment
//                this.salary = salary
//                this.other = other
//            }
//        }
//
//        export class Retrieve {
//            paymentType?: PaymentType
//            startDate?: IsoDate
//            endDate?: IsoDate
//            cashboxIds: string[]
//
//            constructor(
//                cashboxIds: string[],
//                paymentType?: PaymentType,
//                startDate?: IsoDate,
//                endDate?: IsoDate
//            ) {
//                this.paymentType = paymentType
//                this.startDate = startDate
//                this.endDate = endDate
//                this.cashboxIds = cashboxIds
//            }
//        }
//    }
//
//    export namespace Responses {
//        export class Full {
//            id: string // TODO: UUID представлено как строка??
//            createDate: IsoDate
//            price: Price
//            paymentType: PaymentType
//
//            constructor(
//                id: string, // TODO: UUID представлено как строка??
//                createDate: IsoDate,
//                price: Price,
//                paymentType: PaymentType
//            ) {
//                this.id = id
//                this.createDate = createDate
//                this.price = price
//                this.paymentType = paymentType
//            }
//        }
//    }
//}
