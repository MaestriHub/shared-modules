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

    async getCurrentAccessToken() {
        const cookies = await this.cookieStore;
        return cookies.get(ACCESS_TOKEN)?.value;
    }

    async getCurrentDeviceId() { 
        const cookies = await this.cookieStore;
        return cookies.get(DEVICE_ID)?.value;
    }
    
    async getCurrentRefreshToken() {
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
        cookies.set(DEVICE_ID, id, {maxAge: DEVICE_ID_LIFETIME, httpOnly: true})
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
