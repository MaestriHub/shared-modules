import { AuthService } from "../services/AuthService";

const testToken: string = "I'm_test_token!"

const AuthFull = await AuthService.TestAuth( testToken )

console.log(AuthFull.accessToken)