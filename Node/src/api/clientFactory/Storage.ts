import { UUID } from "../../dto/tsPrimitives/UUID";
import { ACCESS_LIFETIME, ACCESS_TOKEN, DEVICE_ID, DEVICE_ID_LIFETIME, REFRESH_LIFETIME, REFRESH_TOKEN } from "./env";
import { ReadonlyRequestCookies } from "next/dist/server/web/spec-extension/adapters/request-cookies";

export const mockStorage = new Map<string, string>()

export interface Tokens {
    accessToken: string,
    refreshToken: string
}

export interface MyStorage {
    getCurrentAccessToken(): Promise<string>
    getCurrentDeviceId(): Promise<UUID>
    getCurrentRefreshToken(): Promise<string>
    setRefreshedTokens(tokens: Tokens): Promise<void>
    setDeviceId(id: UUID): Promise<void>
    logout(): Promise<void>
}

export class CookieStorage implements MyStorage {
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
    }

    async setDeviceId(id: UUID) {
        const cookies = await this.cookieStore;
        cookies.delete(DEVICE_ID)
        cookies.set(DEVICE_ID, id.uuid, {maxAge: DEVICE_ID_LIFETIME, httpOnly: true})
    }
    
    async logout() {
        const cookies = await this.cookieStore;
        cookies.delete(ACCESS_TOKEN)
        cookies.delete(REFRESH_TOKEN)
        cookies.delete(DEVICE_ID)
    }
}

export class TestStorage implements MyStorage{
    store = mockStorage

    constructor() {}

    async getCurrentAccessToken(): Promise<string> {
        const token = this.store.get(ACCESS_TOKEN)
        if (typeof token === "string") {
            return token;
        } else {
            return "";
        }
    }

    async getCurrentDeviceId(): Promise<UUID | null>  { 
        const deviceId = this.store.get(DEVICE_ID)
        if (typeof deviceId === "string") {
            return new UUID(deviceId);
        } else {
            return null
        }
    }
    
    async getCurrentRefreshToken(): Promise<string> {
        const token = this.store.get(REFRESH_TOKEN)
        if (typeof token === "string") {
            return token;
        } else {
            return "";
        }
    }
    
    async setRefreshedTokens(tokens: Tokens) {
        this.store.delete(ACCESS_TOKEN);
        this.store.delete(REFRESH_TOKEN);
        this.store.set(ACCESS_TOKEN, tokens.accessToken);
        this.store.set(REFRESH_TOKEN, tokens.refreshToken);
    }

    async setDeviceId(id: UUID) {
        this.store.delete(DEVICE_ID);
        this.store.set(DEVICE_ID, id.uuid);
    }
    
    async logout() {
        this.store.delete(ACCESS_TOKEN);
        this.store.delete(REFRESH_TOKEN);
        this.store.delete(DEVICE_ID);
    }
}