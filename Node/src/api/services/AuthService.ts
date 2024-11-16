import { client } from "../clientFactory/Client";
import { Auth } from "../../dto/objects/Auth"
import { AxiosInstance } from "axios";
import { cookies } from "next/headers";

enum Paths {
  GoogleAuth = "auth/google",
  AppleAuth = "auth/apple",
  TestAuth = "auth/test/",
}

export class AuthService {
  private client: AxiosInstance

  constructor() { 
    if (process.env.NODE_ENV === 'production') {
      this.client = client(cookies())
      console.log('production env')
    } else {
      this.client = client(new Map())
      console.log('test env')
    }
  }
  
  async GoogleAuth(body: Auth.Parameters.GoogleToken): Promise<Auth.Responses.Full> {
    const response = await this.client.post(Paths.GoogleAuth, {
      data: body
    })

    return response.data;
  }

  async AppleAuth(body: Auth.Parameters.AppleToken): Promise<Auth.Responses.Full> {
    const response = await this.client.post(Paths.AppleAuth, {
      data: body,
    })

    return response.data;
  }

  async TestAuth(testToken: string): Promise<Auth.Responses.Full> {
    const customUrl = Paths.TestAuth + testToken
    const response = await this.client.post(customUrl)

    return response.data
  }
}