// MARK: NO NEED FOR WEB TEMPORE
//import { DateInterval } from "../tsPrimitives/DateInterval"
//import { Price } from "../primitives/Price"
//import { Address } from "../primitives/Address"
//import { AppointmentStatus } from "../enums/AppointmentStatus"
//import { AppointmentType } from "../enums/AppointmentType"
//
//export namespace AppointmentEmployee {
//
//    export namespace Parameters {
//
//        export class Retrieve {
//            startDate?: Date
//            endDate?: Date
//            employees?: string[]
//            salons?: string[]
//            
//            constructor(
//                startDate?: Date,
//                endDate?: Date,
//                employees?: string[],
//                salons?: string[],
//            ) {
//                this.startDate = startDate
//                this.endDate = endDate
//                this.employees = employees
//                this.salons = salons
//            }
//        }
//
//        export class Create {
//            type: AppointmentType
//            time: DateInterval
//
//            constructor(
//                type: AppointmentType,
//                time: DateInterval
//            ) {
//                this.type = type
//                this.time = time
//            }
//        }
//
//        export class Patch {
//            time: DateInterval
//
//            constructor(
//                time: DateInterval
//            ) {
//                this.time = time
//            }
//        }
//    }
//
//    export namespace Responses {
//
//        export class Full {
//            id: string
//            status: AppointmentStatus
//            // salon: TODO:
//            // procedures:
//            time: DateInterval
//            price: Price
//            address: Address
//
//            constructor(
//                id: string,
//                status: AppointmentStatus,
//                // salon: TODO:
//                // procedures:
//                time: DateInterval,
//                price: Price,
//                address: Address
//            ) {
//                this.id = id
//                this.status = status
//                this.time = time
//                this.price = price
//                this.address = address
//            }
//        }
//
//        export class Partial {
//            id: string
//            status: AppointmentStatus
//            // procedures:
//            time: DateInterval
//            price: Price
//
//            constructor(
//                id: string,
//                status: AppointmentStatus,
//                // procedures:
//                time: DateInterval,
//                price: Price
//            ) {
//                this.id = id
//                this.status = status
//                this.time = time
//                this.price = price
//            }
//        }
//    }
//}
