import { clientFactory } from "./Configure";
import { BASE_URL, REQUEST_TIMEOUT } from "./env";
import { AxiosInstance } from "axios";
import { MyStorage } from "./Storage";

export function client(storage: MyStorage): AxiosInstance {
    return clientFactory({
        options: {
            baseURL: BASE_URL,
            timeout: REQUEST_TIMEOUT, // 15 secs timeout
            headers: {
                Accept: "*/*",
                "Requester-Type": "professional",
                "Accept-Language": "en-US;q=1.0",
                "Accept-Encoding": "br;q=1.0, gzip;q=0.9, deflate;q=0.8",
                "Content-Type": "application/json; charset=utf-8",
            }
        },
        storage: storage
    })
}