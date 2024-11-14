import * as Contact from './Contact'
import { UserRoleSet } from '../optionSet/UserRoleSet'
import { MaestriPermissionSet } from '../optionSet/MaestriPermissionSet'

export type User = Parameters | Responses

type Parameters =  Patch

type Responses = Full | Partial

interface Patch {
    nickname: string | undefined
    avatar: URL | undefined
    contact: Contact.Create | undefined
}

export interface Full {
    id: string
    avatar: URL | undefined
    nickname: string
    contact: Contact.Full | undefined
    options: UserRoleSet
    permissions: MaestriPermissionSet
}

interface Partial {
    avatar: URL | undefined
    nickname: string
}