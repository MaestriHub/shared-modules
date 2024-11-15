import { client } from "../clientFactory/Client";
import * as Auth from "../../dto/objects/Auth"

interface Response {}
interface Request {}

enum Paths {
  GoogleAuth = "auth/google",
  AppleAuth = "auth/apple",
  TestAuth = "foo",
}

export class AuthService {
  static async GoogleAuth(someValues): Promise<{ error: boolean; data: Auth.Full }> {
    const specificHeaders = {}
    const someBody: Auth.GoogleToken = someValues.someBody
    const someQuery: Request = ""

    const response = await client.post(Paths.GoogleAuth, {
      headers: specificHeaders,
      params: someQuery,
      data: someBody,
    })

    const resultDTO: Auth.Full = response.data;

    return { error: false, data: resultDTO };
  }

  static async AppleAuth(someValues): Promise<{ error: boolean; data: Auth.Full }> {
    const specificHeaders = {}
    const someBody: Auth.AppleToken = someValues.someBody
    const someQuery: Request = ""

    const response = await client.post(Paths.AppleAuth, {
      headers: specificHeaders,
      params: someQuery,
      data: someBody,
    })

    const resultDTO: Auth.Full = response.data;

    return { error: false, data: resultDTO };
  }

  static async TestAuth(someValues): Promise<{ error: boolean; data: Auth.Full }> {
    const specificHeaders = {}
    const someBody: Request = ""
    const someQuery: Request = ""

    const response = await client.post(Paths.TestAuth, {
      headers: specificHeaders,
      params: someQuery,
      data: someBody,
    })

    const resultDTO: Auth.Full = response.data;

    return { error: false, data: resultDTO };
  }
}