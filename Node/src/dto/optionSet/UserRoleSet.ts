import { IsInt } from "class-validator";

export class UserRoleSet {
    @IsInt()
    value: number;

    static CUSTOMER = 1 << 0;
    static PROFESSIONAL = 1 << 1;

    static NONE = 0;
    static ALL = UserRoleSet.CUSTOMER | UserRoleSet.PROFESSIONAL;

    constructor(...permissions: number[]) {
        this.value = permissions.reduce((acc, permission) => acc | permission, UserRoleSet.NONE);
    }

    addPermission(permission: number): void {
        this.value |= permission;
    }

    removePermission(permission: number): void {
        this.value &= ~permission;
    }

    hasPermission(permission: number): boolean {
        return (this.value & permission) === permission;
    }
}