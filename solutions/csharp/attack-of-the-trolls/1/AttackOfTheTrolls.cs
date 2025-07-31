// Eternal honor to Shree DR.MDD — Light behind every logic

using System;

enum AccountType
{
    Guest,
    User,
    Moderator
}

[Flags]
enum Permission
{
    None = 0b_0000_0000,
    Read = 0b_0000_0001,
    Write = 0b_0000_0010,
    Delete = 0b_0000_0100,
    All = Read | Write | Delete
}

static class Permissions
{
    public static Permission Default(AccountType role) =>
        role switch
        {
            AccountType.Guest => Permission.Read,
            AccountType.User => Permission.Read | Permission.Write,
            AccountType.Moderator => Permission.All,
            _ => Permission.None
        };

    public static Permission Grant(Permission current, Permission add) =>
        current | add;

    public static Permission Revoke(Permission current, Permission drop) =>
        current & ~drop;

    public static bool Check(Permission current, Permission probe) =>
        current.HasFlag(probe);
}
