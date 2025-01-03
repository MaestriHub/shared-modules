import { client } from "../clientFactory/Client";
import { Auth } from "../../dto/objects/Auth"
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";
import { CookieStorage, MyStorage, TestStorage } from "../clientFactory/Storage";

const Paths = {
    GoogleAuth: "auth/google",
    AppleAuth:  "auth/apple",
    TestAuth:   "auth/test/",
}

export class AuthService {
    private client: AxiosInstance
    private storage: MyStorage

    constructor() { 
        if (process.env.NODE_ENV === 'production') {
            this.storage = new CookieStorage(cookies())
        } else {
            this.storage = new TestStorage()
        }
        this.client = client(this.storage)
    }
  
    async GoogleAuth(body: Auth.Parameters.GoogleToken): Promise<Auth.Responses.Full> {
        const response = await this.client.post(
            Paths.GoogleAuth, 
            body
        )
        const AuthFull: Auth.Responses.Full = response.data

        await this.storage.setRefreshedTokens({
            accessToken:  AuthFull.accessToken.value,
            refreshToken: AuthFull.refreshToken.value
        })

        return AuthFull;
    }

    async AppleAuth(body: Auth.Parameters.AppleToken): Promise<Auth.Responses.Full> {
        const response = await this.client.post(
            Paths.AppleAuth, 
            body
        )
        const AuthFull: Auth.Responses.Full = response.data

        await this.storage.setRefreshedTokens({
            accessToken:  AuthFull.accessToken.value,
            refreshToken: AuthFull.refreshToken.value
        })

        return response.data;
    }

    async TestAuth(testToken: string): Promise<Auth.Responses.Full> {
        const response = await this.client.post(
            Paths.TestAuth + testToken
        )
        const AuthFull: Auth.Responses.Full = response.data

        await this.storage.setRefreshedTokens({
            accessToken:  AuthFull.accessToken.value,
            refreshToken: AuthFull.refreshToken.value
        })

        return AuthFull;
    }
}