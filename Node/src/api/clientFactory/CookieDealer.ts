import { cookies } from "next/headers";
import { ACCESS_LIFETIME, ACCESS_TOKEN, REFRESH_LIFETIME, REFRESH_TOKEN } from "./env";
import { ReadonlyRequestCookies } from "next/dist/server/web/spec-extension/adapters/request-cookies";

export interface Tokens {
    accessToken: string,
    refreshToken: string
}

export class CookieDealer {
    cookieStore: Promise<ReadonlyRequestCookies>

    constructor(cookieStore: Promise<ReadonlyRequestCookies>){
        this.cookieStore = cookieStore;
    }

    async getCurrentAccessToken(){
        const cookies = await this.cookieStore;
        return cookies.get(ACCESS_TOKEN)?.value;
    }
    
    async getCurrentRefreshToken(){
        const cookies = await this.cookieStore;
        return cookies.get(REFRESH_TOKEN)?.value;
    }
    
    async setRefreshedTokens(tokens: Tokens){
        const cookies = await this.cookieStore;
        cookies.delete(ACCESS_TOKEN)
        cookies.delete(REFRESH_TOKEN)
        cookies.set(ACCESS_TOKEN, tokens.accessToken, {maxAge: ACCESS_LIFETIME})
        cookies.set(REFRESH_TOKEN, tokens.refreshToken, {maxAge: REFRESH_LIFETIME})
        console.log('set tokens...')
    }
    
    async logout(){
        const cookies = await this.cookieStore;
        cookies.delete(ACCESS_TOKEN)
        cookies.delete(REFRESH_TOKEN)
        console.log('logout...')
    }
}
