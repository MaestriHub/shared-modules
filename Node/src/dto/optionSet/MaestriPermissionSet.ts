export enum MaestriPermissionSet {
    SERVICE = 1 << 0, // Разрешаем создавать свои сервисы
    
    NONE = 0,
    FULL = MaestriPermissionSet.SERVICE,
}

export function addPermission(set: MaestriPermissionSet, permission: MaestriPermissionSet): MaestriPermissionSet {
    return set | permission;
}

export function removePermission(set: MaestriPermissionSet, permission: MaestriPermissionSet): MaestriPermissionSet {
    return set & ~permission;
}

export function hasPermission(set: MaestriPermissionSet, permission: MaestriPermissionSet): boolean {
    return (set & permission) === permission;
}