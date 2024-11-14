import { headers } from "next/headers";

export async function HeadersFoxAxios(accessToken: string) {
    //const acceptLanguage = (await headers()).get("accept-language") || "en-US;q=1.0";
    return {
      Authorization: `Bearer ${accessToken}`,
      Accept: "*/*",
      "Requester-Type": "professional",
      "Accept-Language": "en-US;q=1.0",
      "Accept-Encoding": "br;q=1.0, gzip;q=0.9, deflate;q=0.8"
    };
  }