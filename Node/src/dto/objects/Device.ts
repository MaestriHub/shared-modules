import { VersionType } from "../enums/VersionType"

export type Device = Parameters | Responses

type Parameters =  System

type Responses = Full

interface System {
    manuFacturer: string | undefined
    model: string | undefined
    system: SystemType | undefined
    appVersion: string | undefined
    country: string | undefined
    fcmToken: string | undefined
}

interface Full {
    id: string
    version: VersionType | undefined
}