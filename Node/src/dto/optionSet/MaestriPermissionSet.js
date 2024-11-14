"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.MaestriPermissionSet = void 0;
var MaestriPermissionSet = /** @class */ (function () {
    function MaestriPermissionSet() {
        var permissions = [];
        for (var _i = 0; _i < arguments.length; _i++) {
            permissions[_i] = arguments[_i];
        }
        this.value = permissions.reduce(function (acc, permission) { return acc | permission; }, MaestriPermissionSet.NONE);
    }
    MaestriPermissionSet.prototype.addPermission = function (permission) {
        this.value |= permission;
    };
    MaestriPermissionSet.prototype.removePermission = function (permission) {
        this.value &= ~permission;
    };
    MaestriPermissionSet.prototype.hasPermission = function (permission) {
        return (this.value & permission) === permission;
    };
    MaestriPermissionSet.SERVICE = 1 << 0; // Разрешаем создавать свои сервисы
    MaestriPermissionSet.NONE = 0;
    MaestriPermissionSet.FULL = MaestriPermissionSet.SERVICE;
    return MaestriPermissionSet;
}());
exports.MaestriPermissionSet = MaestriPermissionSet;
