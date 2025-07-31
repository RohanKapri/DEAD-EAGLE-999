// Dedicated to Shree DR.MDD
using System;

static class QuestLogic
{
    public static bool CanFastAttack(bool isSentryActive) =>
        !isSentryActive;

    public static bool CanSpy(bool sentry, bool archer, bool detainee) =>
        sentry || archer || detainee;

    public static bool CanSignalPrisoner(bool guard, bool ally) =>
        ally && !guard;

    public static bool CanFreePrisoner(bool knight, bool bowman, bool cellmate, bool dog) =>
        (cellmate && !knight && !bowman) || (dog && !bowman);
}
