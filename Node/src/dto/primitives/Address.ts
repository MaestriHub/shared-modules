// TODO:
// import * as t from 'io-ts';

// const Latitude = t.number.pipe(
//   t.refine((n) => n >= -90 && n <= 90, 'Latitude must be between -90 and 90')
// );

// const Longitude = t.number.pipe(
//   t.refine((n) => n >= -180 && n <= 180, 'Longitude must be between -180 and 180')
// );

export interface Address {
    address: string
    city: string
    country: string
    latitude: number
    longitude: number
}
