export enum UserRoleSet {
    CUSTOMER = 1 << 0,
    PROFESSIONAL = 1 << 1,
    
    ALL = UserRoleSet.CUSTOMER | UserRoleSet.PROFESSIONAL
}

// TODO: может можно сделать эти функции интерфейсом для optionSetov

export function addPermission(set: UserRoleSet, permission: UserRoleSet): UserRoleSet {
    return set | permission;
}

export function removePermission(set: UserRoleSet, permission: UserRoleSet): UserRoleSet {
    return set & ~permission;
}

export function hasPermission(set: UserRoleSet, permission: UserRoleSet): boolean {
    return (set & permission) === permission;
}