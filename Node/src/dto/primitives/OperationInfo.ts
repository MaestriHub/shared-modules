// MARK: NEED BRAINSTORM
//export class OperationInfo {
//    type: OperationInfo.Keys
//
//
//    /**
//     * @deprecated
//     * пока что не используется и вероятно поменяется
//     */
//    constructor(
//        type: OperationInfo.AppointmentOperation | OperationInfo.SalaryOperation | OperationInfo.OtherOperation
//    ) {
//        this.type = type   
//    }
//}
//
//export namespace OperationInfo {
//
//    export class AppointmentOperation {
//        realizerId: string
//        appointmentId: string
//
//        constructor(
//            realizerId: string, 
//            appointmentId: string
//        ) {
//            this.realizerId = realizerId
//            this.appointmentId = appointmentId
//        }
//    }
//
//    export class SalaryOperation {
//        initiatorId: string
//        receiverId: string
//        dateTo: Date
//
//        constructor(
//            initiatorId: string, 
//            receiverId: string, 
//            dateTo: Date
//        ) {
//            this.initiatorId = initiatorId
//            this.receiverId = receiverId
//            this.dateTo = dateTo
//        }
//    }
//
//    export class OtherOperation {
//        realizerId: string
//        description: string
//
//        constructor(
//            realizerId: string, 
//            description: string
//        ) {
//            this.realizerId = realizerId
//            this.description = description
//        }
//    }
//
//    export class Keys {} // Mark: бекендер придет и добра принесет в будущем
//}
