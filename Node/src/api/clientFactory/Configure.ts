import axios from 'axios';
import { REFRESH_TOKEN_BAD_MESSAGE, REFRESH_TOKEN_EXPIRED_MESSAGE, REFRESH_TOKEN_URL } from './env';
import { UUID } from '../../dto/tsPrimitives/UUID';
import {  v4 as uuidv4 } from 'uuid';

// TODO: Протестировать. Проблема при конверизации запросов. Нужно придумать локальную очередь если падает
// то нужно пойти обновить токены а другие пусть ждуть этого события
    // Функция рекурсивного преобразования всех дат в объекте
export function clientFactory({ options, storage }) {
    const client = axios.create(options);
    const cookie = storage
    
    client.interceptors.request.use(
        async (config) => {
            if (config.headers.authorization !== false) {
                const token = await cookie.getCurrentAccessToken();
                config.headers.Authorization = "Bearer " + token;
            }

            let deviceID = await cookie.getCurrentDeviceId()
            if (deviceID != null) {
                config.headers["Device-ID"] = deviceID.uuid;
            } else {
                const newDeviceId = new UUID(uuidv4())
                await cookie.setDeviceId(newDeviceId)
                config.headers["Device-ID"] = newDeviceId.uuid;
            }
            return config;
        },
        (error) => {
            throw error;
        }
    );

    client.interceptors.response.use(
        (response) => {
            return response;
        },
        async (error) => {
            if (error.config?.retry === true) { //TODO: нужно точно разобраться как это работает
                return
            }

            const handleError = (error) => {
                cookie.logout();
                throw error;
            };

            const originalRequest = error.config

            originalRequest.headers = JSON.parse(
                JSON.stringify(originalRequest.headers || {})
            );

            // AUTH ROUTER PROBLEM NEED PANIC
            //TODO: вероятно еще бывают ошибки и вообще нужно подумать
            if (error.response.data.reason === 'malformed JWT') {
                handleError(error);
            }
      
            const refreshToken = await cookie.getCurrentRefreshToken();
      
            // TODO: Нужно подумать над правильностью recovery 
            if (
                refreshToken &&
                error.response?.status === 401 &&
                originalRequest?.url !== REFRESH_TOKEN_URL &&
                error.response?.data?.message !== REFRESH_TOKEN_BAD_MESSAGE &&
                error.response?.data?.message !== REFRESH_TOKEN_EXPIRED_MESSAGE
            ) {
                originalRequest.retry = true;

                return client
                    .post(REFRESH_TOKEN_URL, refreshToken)
                    .then(async (res) => {
                        const tokens = {
                            accessToken: res.data?.accessToken,
                            refreshToken: res.data?.refreshToken,
                        };
                        await cookie.setRefreshedTokens(tokens);
                        return client(originalRequest);
                    }, handleError)
            }

             // Refresh token missing or expired => logout user...
            error.response.status === 401 ? handleError(error) : null
      
            // TODO: Нужно ли что-то еще?
            throw error
        }
    )

    return client
}