"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserRoleSet = void 0;
var UserRoleSet = /** @class */ (function () {
    function UserRoleSet() {
        var permissions = [];
        for (var _i = 0; _i < arguments.length; _i++) {
            permissions[_i] = arguments[_i];
        }
        this.value = permissions.reduce(function (acc, permission) { return acc | permission; }, UserRoleSet.NONE);
    }
    UserRoleSet.prototype.addPermission = function (permission) {
        this.value |= permission;
    };
    UserRoleSet.prototype.removePermission = function (permission) {
        this.value &= ~permission;
    };
    UserRoleSet.prototype.hasPermission = function (permission) {
        return (this.value & permission) === permission;
    };
    UserRoleSet.CUSTOMER = 1 << 0;
    UserRoleSet.PROFESSIONAL = 1 << 1;
    UserRoleSet.NONE = 0;
    UserRoleSet.ALL = UserRoleSet.CUSTOMER | UserRoleSet.PROFESSIONAL;
    return UserRoleSet;
}());
exports.UserRoleSet = UserRoleSet;
