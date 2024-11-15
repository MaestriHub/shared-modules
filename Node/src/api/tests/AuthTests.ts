import { GetServerSideProps } from "next";
import { AuthService } from "../services/AuthService";

const testToken: string = "I'm_test_token!"

const SalonPage = async ({ params }: { params: { id: string } }) => {
    const AuthFull = await new AuthService().TestAuth(testToken)
    console.log(AuthFull)
    return 1
}