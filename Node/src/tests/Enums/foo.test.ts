import { formatRFC3339 } from 'date-fns'

test("хуй", async () => {
    const date = formatRFC3339(new Date().toISOString())
    console.log(date)
})

test("пизда", async () => {
    const date = "2024-10-20T00:00:00Z"
    const res = Date.parse(date)
    const date2 = "2024-11-20T22:44:26.622Z"
    const res2 = Date.parse(date2)
    console.log(res)
    console.log(res2)
})