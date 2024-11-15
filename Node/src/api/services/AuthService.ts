import { client } from "../clientFactory/Client";
import * as Auth from "../../dto/objects/Auth"

enum Paths {
  GoogleAuth = "auth/google",
  AppleAuth = "auth/apple",
  TestAuth = "auth/test/",
}

export class AuthService {
  static async GoogleAuth(body: Auth.GoogleToken): Promise<Auth.Full> {
    const response = await client.post(Paths.GoogleAuth, {
      data: body
    })

    return response.data;
  }

  static async AppleAuth(body: Auth.AppleToken): Promise<Auth.Full> {
    const response = await client.post(Paths.AppleAuth, {
      data: body,
    })

    return response.data;
  }

  static async TestAuth(testToken: string): Promise<Auth.Full> {
    const customUrl = Paths.TestAuth + testToken
    const response = await client.post(customUrl)

    return response.data
  }
}