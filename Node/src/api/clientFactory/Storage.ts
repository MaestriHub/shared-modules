import { UUID } from "../../dto/tsPrimitives/UUID";
import { ACCESS_LIFETIME, ACCESS_TOKEN, DEVICE_ID, DEVICE_ID_LIFETIME, REFRESH_LIFETIME, REFRESH_TOKEN } from "./env";
import { ReadonlyRequestCookies } from "next/dist/server/web/spec-extension/adapters/request-cookies";

export interface Tokens {
    accessToken: string,
    refreshToken: string
}

export class Storage {
    cookieStore: Promise<ReadonlyRequestCookies>

    constructor(cookieStore: Promise<ReadonlyRequestCookies>) {
        this.cookieStore = cookieStore;
    }

    async getCurrentAccessToken(): Promise<string> {
        const cookies = await this.cookieStore;
        return cookies.get(ACCESS_TOKEN)?.value;
    }

    async getCurrentDeviceId(): Promise<UUID> { 
        const cookies = await this.cookieStore;
        return new UUID(cookies.get(DEVICE_ID)?.value);
    }
    
    async getCurrentRefreshToken(): Promise<string> {
        const cookies = await this.cookieStore;
        return cookies.get(REFRESH_TOKEN)?.value;
    }
    
    async setRefreshedTokens(tokens: Tokens) {
        const cookies = await this.cookieStore;
        cookies.delete(ACCESS_TOKEN)
        cookies.delete(REFRESH_TOKEN)
        cookies.set(ACCESS_TOKEN, tokens.accessToken, {maxAge: ACCESS_LIFETIME, httpOnly: true})
        cookies.set(REFRESH_TOKEN, tokens.refreshToken, {maxAge: REFRESH_LIFETIME, httpOnly: true})
        console.log('set tokens...')
    }

    async setDeviceId(id: UUID) {
        const cookies = await this.cookieStore;
        cookies.delete(DEVICE_ID)
        cookies.set(DEVICE_ID, id.uuid, {maxAge: DEVICE_ID_LIFETIME, httpOnly: true})
        console.log('set tokens...')
    }
    
    async logout() {
        const cookies = await this.cookieStore;
        cookies.delete(ACCESS_TOKEN)
        cookies.delete(REFRESH_TOKEN)
        cookies.delete(DEVICE_ID)
        console.log('logout...')
    }
}