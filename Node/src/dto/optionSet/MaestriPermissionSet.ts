import { isInt, IsInt } from "class-validator";

export class MaestriPermissionSet {
    @IsInt()
    value: number;

    static SERVICE = 1 << 0; // Разрешаем создавать свои сервисы

    static NONE = 0;
    static FULL = MaestriPermissionSet.SERVICE;

    constructor(...permissions: number[]) {
        this.value = permissions.reduce((acc, permission) => acc | permission, MaestriPermissionSet.NONE);
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

    toJSON() {
        return this.value;
    }

    static fromJSON(json: any): MaestriPermissionSet {
        if (!isInt(json)) {
            throw new Error("Invalid Int")
        }
        return new MaestriPermissionSet(Number(json));
    }
}