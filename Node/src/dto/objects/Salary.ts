import { SalaryPaymentType } from "../enums/SalaryPaymentType";
import { Int } from "../tsPrimitives/Int";
import { Wage } from "../primitives/Wage";
import { Price } from "../primitives/Price";
import { UUID } from "../tsPrimitives/UUID";
import { Service } from "./Service";

export namespace Salary {
    
    export namespace Parameters {
        
        export namespace Rules {

            export class Create {
                percent?: Int
                grid?: Map<UUID, SalaryPaymentType>
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
                paymentType: SalaryPaymentType
                dateTo: Date

                constructor(
                    paymentType: SalaryPaymentType,
                    dateTo: Date
                ) {
                    this.paymentType = paymentType
                    this.dateTo = dateTo
                }
            }

            export class Calculate {
                dateTo: Date

                constructor(
                    dateTo: Date
                ) {
                    this.dateTo = dateTo
                }
            }
        }
    }
    
    export namespace Responses {
        
        export namespace Rules {
            
            export class Full {
                percent?: Int
                grid?: Map<Service.Responses.Partial, SalaryPaymentType>
                wage?: Wage

                constructor(
                    percent?: Int,
                    grid?: Map<Service.Responses.Partial, SalaryPaymentType>,
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
                wage?: Price
                grid?: Price[]
                procent?: Price[]
                sum?: Price[]

                constructor(
                    wage?: Price,
                    grid?: Price[],
                    procent?: Price[],
                    sum?: Price[],
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