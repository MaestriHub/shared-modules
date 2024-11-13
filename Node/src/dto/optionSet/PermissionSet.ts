export enum PermissionSet {
    OWNER = 1 << 0,

    APPOINTMENTS = 1 << 1,
    STATISTIC = 1 << 2,
    EMPLOYEE = 1 << 3,
    TIMETABLE = 1 << 4,
    NOTIFICATIONS = 1 << 5,
    SALON = 1 << 6,
    FINANCE = 1 << 7,
    PROCEDURE = 1 << 8,
    CONTACT = 1 << 9,
    POSITION = 1 << 10,
    SALARY = 1 << 11,

    NONE = 0,
    FULL = 
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
        PermissionSet.SALARY,
}

// TODO: может можно сделать эти функции интерфейсом для optionSetov

export function addPermission(set: PermissionSet, permission: PermissionSet): PermissionSet {
    return set | permission;
}

export function removePermission(set: PermissionSet, permission: PermissionSet): PermissionSet {
    return set & ~permission;
}

export function hasPermission(set: PermissionSet, permission: PermissionSet): boolean {
    return (set & permission) === permission;
}