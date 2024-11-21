export const BASE_URL = 'http://localhost:8080/v1/'
export const REFRESH_TOKEN_URL = 'refresh'

export const REFRESH_TOKEN = "refreshToken"
export const ACCESS_TOKEN = "accessToken"
export const DEVICE_ID = "Device-ID"

export const REFRESH_TOKEN_BAD_MESSAGE = "Токен плохой"
export const REFRESH_TOKEN_EXPIRED_MESSAGE = "Рефреш токен уже умер"

export const REFRESH_LIFETIME = 60 * 60 * 24 * 90
export const ACCESS_LIFETIME = 60 * 60
export const DEVICE_ID_LIFETIME = 60 * 60 * 24 * 360 // 1 year

export const REQUEST_TIMEOUT = 15 * 1000
