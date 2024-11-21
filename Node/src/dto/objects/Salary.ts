import { SalaryPaymentType } from "../enums/SalaryPaymentType";
import { Int } from "../tsPrimitives/Int";
import { Wage } from "../primitives/Wage";
import { Price } from "../primitives/Price";
import { UUID } from "../tsPrimitives/UUID";
import { Service } from "./Service";
import { ValidateNested } from "class-validator";
import { IsoDate } from "../tsPrimitives/IsoDate";

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
                paymentType: SalaryPaymentType
                dateTo: IsoDate

                constructor(
                    paymentType: SalaryPaymentType,
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
        
        export namespace Rules {
            
            export class Full {
                @ValidateNested()
                percent?: Int

                @ValidateNested()
                grid?: Map<Service.Responses.Partial, SalaryPaymentType>

                @ValidateNested()
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
                @ValidateNested()
                wage?: Price

                @ValidateNested()
                grid?: Price[]

                @ValidateNested()
                procent?: Price[]

                @ValidateNested()
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