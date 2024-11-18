import { ReadonlyRequestCookies } from "next/dist/server/web/spec-extension/adapters/request-cookies";
import { clientFactory } from "./Configure";
import { BASE_URL, REQUEST_TIMEOUT } from "./env";
import { AxiosInstance } from "axios";

type TestStorage = Map<string, string>
type ProductionStorage = Promise<ReadonlyRequestCookies>

export function client(storage: ProductionStorage | TestStorage): AxiosInstance {
    return clientFactory({
        options: {
            baseURL: BASE_URL,
            timeout: REQUEST_TIMEOUT, // 15 secs timeout
            headers: {
                Accept: "*/*",
                "Requester-Type": "professional",
                "Accept-Language": "en-US;q=1.0",
                "Accept-Encoding": "br;q=1.0, gzip;q=0.9, deflate;q=0.8",
            }
        },
        storage: storage
    })
}