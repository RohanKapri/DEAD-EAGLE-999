using System;

public static class ErrorHandling
{
    public static void HandleErrorByThrowingException() =>
        throw new Exception();

    public static int? HandleErrorByReturningNullableType(string input) =>
        int.TryParse(input, out var output) ? output : null;

    public static bool HandleErrorWithOutParam(string input, out int result) =>
        int.TryParse(input, out result);

    public static void DisposableResourcesAreDisposedWhenExceptionIsThrown(IDisposable disposableObject)
    {
        disposableObject.Dispose();
        throw new Exception();
    }
}