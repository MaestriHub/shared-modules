export class PermissionSet {
    value: number;

    static OWNER = 1 << 0;

    static APPOINTMENTS = 1 << 1;
    static STATISTIC = 1 << 2;
    static EMPLOYEE = 1 << 3;
    static TIMETABLE = 1 << 4;
    static NOTIFICATIONS = 1 << 5;
    static SALON = 1 << 6;
    static FINANCE = 1 << 7;
    static PROCEDURE = 1 << 8;
    static CONTACT = 1 << 9;
    static POSITION = 1 << 10;
    static SALARY = 1 << 11;

    static NONE = 0;
    static FULL = 
        PermissionSet.APPOINTMENTS  | 
        PermissionSet.STATISTIC     | 
        PermissionSet.EMPLOYEE      | 
        PermissionSet.TIMETABLE     | 
        PermissionSet.NOTIFICATIONS | 
        PermissionSet.SALON         | 
        PermissionSet.FINANCE       | 
        PermissionSet.PROCEDURE     | 
        PermissionSet.CONTACT       | 
        PermissionSet.POSITION      | 
        PermissionSet.SALARY;

    constructor(...permissions: number[]) {
        this.value = permissions.reduce((acc, permission) => acc | permission, PermissionSet.NONE);
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
