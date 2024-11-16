import axios from 'axios';
import { CookieDealer } from './CookieDealer';
import { REFRESH_TOKEN_URL } from './env';

// TODO: Протестировать. Проблема при конверизации запросов. Нужно придумать локальную очередь если падает
// то нужно пойти обновить токены а другие пусть ждуть этого события
export function clientFactory({ options, storage }) {
  const client = axios.create(options);
  const cookie = new CookieDealer(storage);

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

  client.interceptors.response.use(
    (response) => {
      return response;
    },
    (error) => {
      const originalRequest = error.config

      originalRequest.headers = JSON.parse(
        JSON.stringify(originalRequest.headers || {})
      );
      const refreshToken = cookie.getCurrentRefreshToken();

      const handleError = (error) => {
        cookie.logout();
        throw error;
      };

      if (
        refreshToken &&
        error.response?.status === 401 &&
        originalRequest?.url !== REFRESH_TOKEN_URL &&
        originalRequest?.retry !== true
      ) {
        originalRequest.retry = true;

        return client
          .post(REFRESH_TOKEN_URL, {
            refreshToken: refreshToken,
          })
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
      if (
        error.response?.status === 401 &&
        error.response?.data?.message === "TokenExpiredError"
      ) {
        return handleError(error);
      }
      
      // Any status codes that falls outside the range of 2xx cause this function to trigger
      // Do something with response error
      throw error
    }
  );

  return client;
}