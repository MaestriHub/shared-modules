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

/// MARK: Test

class TokensStorage {
    accessToken: string
    refreshToken: string
}

let storage = new TokensStorage()

export async function testGetCurrentAccessToken() {

    return storage.accessToken
}

export async function testGetCurrentRefreshToken() {
    
    return storage.refreshToken
}

export async function testSetRefreshedTokens(tokens){
    
    console.log('set tokens...')
    storage.accessToken = tokens.accessToken
    storage.refreshToken = tokens.refreshToken
}

export async function testLogout(){

    console.log('logout...')
    storage.accessToken = ''
    storage.refreshToken = ''
}