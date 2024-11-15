import { AuthService } from "../services/AuthService";

const AuthFull = await AuthService.AppleAuth({ someValues: "Foo" })

console.log(AuthFull)