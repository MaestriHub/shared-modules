import { SalaryPaymentType } from "../enums/SalaryPaymentType";
import { Int } from "../tsPrimitives/Int";
import { Wage } from "../primitives/Wage";
import { Price } from "../primitives/Price";
import { UUID } from "../tsPrimitives/UUID";
import { Service } from "./Service";
import { ValidateNested } from "class-validator";
import { IsoDate } from "../tsPrimitives/IsoDate";
import { PaymentType } from "../enums/PaymentType";

export namespace Salary {
    
    export namespace Parameters {
        
        export namespace Rules {

            export class Create {
                @ValidateNested()
                percent?: Int
                
                @ValidateNested()
                grid?: Map<UUID, SalaryPaymentType>

                @ValidateNested()
                wage?: Wage

                constructor(
                    percent?: Int,
                    grid?: Map<UUID, SalaryPaymentType>,
                    wage?: Wage,
                ) {
                    this.percent = percent
                    this.grid = grid
                    this.wage = wage
                }
            }
        }

        export namespace Balance {

            export class Payout {
                paymentType: PaymentType
                dateTo: IsoDate

                constructor(
                    paymentType: PaymentType,
                    dateTo: IsoDate
                ) {
                    this.paymentType = paymentType
                    this.dateTo = dateTo
                }
            }

            export class Calculate {
                dateTo: IsoDate

                constructor(
                    dateTo: IsoDate
                ) {
                    this.dateTo = dateTo
                }
            }
        }
    }
    
    export namespace Responses {

        export namespace Helpers {

            export class ServiceWithPaymentType {
                @ValidateNested()
                service: Service.Responses.Partial

                @ValidateNested()
                paymentType: SalaryPaymentType

                constructor(
                    service: Service.Responses.Partial,
                    paymentType: SalaryPaymentType
                ) {
                    this.service = service
                    this.paymentType = paymentType
                }
            }
        }
        
        export namespace Rules {
            
            export class Full {
                @ValidateNested()
                percent?: Int

                @ValidateNested()
                grid?: Helpers.ServiceWithPaymentType[]

                @ValidateNested()
                wage?: Wage

                constructor(
                    percent?: Int,
                    grid?: Helpers.ServiceWithPaymentType[],
                    wage?: Wage,
                ) {
                    this.percent = percent
                    this.grid = grid
                    this.wage = wage
                }
            }
        }

        export namespace Balance {
            
            export class Full {
                @ValidateNested()
                wage?: Price

                @ValidateNested()
                grid?: Price[]

                @ValidateNested()
                procent?: Price[]

                @ValidateNested()
                sum: Price[]

                constructor(
                    sum: Price[],
                    wage?: Price,
                    grid?: Price[],
                    procent?: Price[],
                ) {
                    this.wage = wage
                    this.grid = grid
                    this.procent = procent
                    this.sum = sum
                }
            }
        }
    }
}