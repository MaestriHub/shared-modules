import { validate } from "class-validator"

export async function ezValidate(some: any) {
    const errors = await validate(some)

    if (errors.length > 0) {
        throw "parse " + some.constructor.name + " error"
    }
}