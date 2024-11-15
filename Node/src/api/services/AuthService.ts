import { client } from "../clientFactory/Client";

interface Response {}
interface Request {}

enum Paths {
  GoogleAuth = "auth/google",
  AppleAuth = "auth/apple",
  Foo = "foo",
}

export class AuthService {
  static async GoogleAuth(someValues) {
    try {
      const specificHeaders = {}
      const someBody: Request = someValues
      const someQuery: Request = someValues

      const response = await client.post(Paths.GoogleAuth, {
        headers: specificHeaders,
        params: someQuery,
        data: someBody,
      })

      const resultDTO: Response = response.data;

      return { error: false, data: resultDTO };
    } catch (error) {
      console.error(error);
      // some state
    }
  }
}