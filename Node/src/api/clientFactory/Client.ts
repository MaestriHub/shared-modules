import { ReadonlyRequestCookies } from "next/dist/server/web/spec-extension/adapters/request-cookies";
import { clientFactory } from "./Configure";
import { BASE_URL } from "./env";

export function client(storage: Promise<ReadonlyRequestCookies>) {
    return clientFactory({
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
        storage: storage
    })
}