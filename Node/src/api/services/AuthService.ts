import { client } from "../clientFactory/Client";
import { Auth } from "../../dto/objects/Auth"

enum Paths {
  GoogleAuth = "auth/google",
  AppleAuth = "auth/apple",
  TestAuth = "auth/test/",
}

export class AuthService {
  static async GoogleAuth(body: Auth.Parameters.GoogleToken): Promise<Auth.Responses.Full> {
    const response = await client.post(Paths.GoogleAuth, {
      data: body
    })

    return response.data;
  }

  static async AppleAuth(body: Auth.Parameters.AppleToken): Promise<Auth.Responses.Full> {
    const response = await client.post(Paths.AppleAuth, {
      data: body,
    })

    return response.data;
  }

  static async TestAuth(testToken: string): Promise<Auth.Responses.Full> {
    const customUrl = Paths.TestAuth + testToken
    const response = await client.post(customUrl)

    return response.data
  }
}
