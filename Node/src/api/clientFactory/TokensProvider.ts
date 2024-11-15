import { cookies } from "next/headers";
import { ACCESS_LIFETIME, ACCESS_TOKEN, REFRESH_LIFETIME, REFRESH_TOKEN } from "./env";

const cookieStore = await cookies();

export async function getCurrentAccessToken() {
    return cookieStore.get(ACCESS_TOKEN)?.value;
}

export async function getCurrentRefreshToken() {
    return cookieStore.get(REFRESH_TOKEN)?.value;
}

interface Tokens {
    accessToken: string
    refreshToken: string
}

export async function setRefreshedTokens(tokens: Tokens){
    cookieStore.delete(ACCESS_TOKEN)
    cookieStore.delete(REFRESH_TOKEN)
    cookieStore.set(ACCESS_TOKEN, tokens.accessToken, {maxAge: ACCESS_LIFETIME})
    cookieStore.set(REFRESH_TOKEN, tokens.refreshToken, {maxAge: REFRESH_LIFETIME})
    console.log('set tokens...')
}

export async function logout(){
    cookieStore.delete(ACCESS_TOKEN)
    cookieStore.delete(REFRESH_TOKEN)
    console.log('logout...')
}