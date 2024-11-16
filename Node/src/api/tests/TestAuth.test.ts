import { AuthService } from "../services/AuthService";

const testToken = "test_npm2"

test("test auth service", async () => {
    const authService = new AuthService()
    const AuthFull = await authService.TestAuth(testToken)
    console.log(AuthFull)
})