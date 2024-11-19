import axios from 'axios';
import { Storage } from './Storage';
import { REFRESH_TOKEN_BAD_MESSAGE, REFRESH_TOKEN_EXPIRED_MESSAGE, REFRESH_TOKEN_URL } from './env';
import { UUID } from '../../dto/tsPrimitives/UUID';

// TODO: Протестировать. Проблема при конверизации запросов. Нужно придумать локальную очередь если падает
// то нужно пойти обновить токены а другие пусть ждуть этого события
export function clientFactory({ options, storage }) {
  const client = axios.create(options);
  const cookie = new Storage(storage);

  client.interceptors.request.use(
    (config) => {
      if (config.headers.authorization !== false) {
        const token = cookie.getCurrentAccessToken();
        if (token) {
          config.headers.Authorization = "Bearer " + token;
        }
      }
      return config;
    },
    (error) => {
      throw error;
    }
  );

  client.interceptors.request.use(
    async (config) => {
      let deviceID = await cookie.getCurrentDeviceId() //TODO:
      if (deviceID === undefined) {
        await cookie.setDeviceId(new UUID()) //TODO: Device ID setter
      }
      config.headers["Device-ID"] = deviceID
      return config;
    },
    (error) => {
      throw error;
    }
  )

  client.interceptors.response.use(
    (response) => {
      return response;
    },
    (error) => {
      if (error.config.retry === true) { //TODO: нужно точно разобраться как это работает
        return
      }

      const handleError = (error) => {
        cookie.logout();
        console.log("ХУЙ!")
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
      
      const refreshToken = cookie.getCurrentRefreshToken();
      
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
          .then((res) => {
            const tokens = {
              accessToken: res.data?.accessToken,
              refreshToken: res.data?.refreshToken,
            };
            cookie.setRefreshedTokens(tokens);

            return client(originalRequest);
          }, handleError)
      }

      // Refresh token missing or expired => logout user...
      error.response.status === 401 ? handleError(error) : null;
      
      // TODO: Нужно ли что-то еще?
      throw error
    }
  );

  return client;
}