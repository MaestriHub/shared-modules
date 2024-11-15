import { clientFactory } from "./Configure";
import * as TokensProvider from "./TokensProvider"
import { BASE_URL } from "./env";
import { REFRESH_TOKEN_URL } from "./env";

export const client = clientFactory({
    options: {
        baseURL: BASE_URL,
        timeout: 300000,
        headers: {
            Accept: "*/*",
            "Requester-Type": "professional",
            "Accept-Language": "en-US;q=1.0",
            "Accept-Encoding": "br;q=1.0, gzip;q=0.9, deflate;q=0.8"
        }
    },
    getCurrentAccessToken: TokensProvider.getCurrentAccessToken,
    getCurrentRefreshToken: TokensProvider.getCurrentRefreshToken,
    refreshTokenUrl: REFRESH_TOKEN_URL,
    logout: TokensProvider.logout,
    setRefreshedTokens: TokensProvider.setRefreshedTokens
})