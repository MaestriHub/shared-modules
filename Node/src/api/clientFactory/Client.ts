import { createClient } from "./configure";
import * as TokensProvider from "./TokensProvider"

export const BASE_URL = 'http://localhost:8080/v1'

export const client = createClient({
    options: {
        baseURL: BASE_URL,
        timeout: 300000,
        // headers: {
        //     ...HeadersFoxAxios(getCurrentAccessToken()),
        // }
    },
    getCurrentAccessToken: TokensProvider.getCurrentAccessToken,
    getCurrentRefreshToken: TokensProvider.getCurrentRefreshToken,
    refreshTokenUrl: TokensProvider.REFRESH_TOKEN_URL,
    logout: TokensProvider.logout,
    setRefreshedTokens: TokensProvider.setRefreshedTokens
})