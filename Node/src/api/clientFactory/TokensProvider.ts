import { HeadersFoxAxios } from "../Headers";

export const REFRESH_TOKEN_URL = 'http://localhost:5000/api/v1/auth/refreshToken'

export async function getCurrentAccessToken() {

    return "access-token"
}

export async function getCurrentRefreshToken() {
    
    return "refresh-token"
}

export async function setRefreshedTokens(tokens){
    console.log('set tokens...')
}

export async function logout(){
    console.log('logout...')
}