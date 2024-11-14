import axios from "axios";
import { HeadersFoxAxios } from "./Headers";
import * as User from "../dto/objects/User"

const token = "foo"

const URL_BACKEND_MAESTRI = "http://localhost:8080"

export async function GoogleAuth() {
    try {
      const accessToken = token;
  
      // мне кажется этого не должно быть в этой функции
      if (!accessToken) {
        return { redirect: "/auth" };
      }

      const headers = await HeadersFoxAxios(accessToken);
      const apiUrl = `${URL_BACKEND_MAESTRI}/v1/users/professional`;
      
      console.log(apiUrl);

      const apiResponse = await axios.post(apiUrl, {
        headers: await HeadersFoxAxios(accessToken)
      });

      const userFullDTO: User.Full  = apiResponse.data;

      console.log(userFullDTO);

      return { error: false, data: userFullDTO };
    } catch (error) {
      console.error(error);
      return { redirect: "/error" };
    }
}

GoogleAuth()