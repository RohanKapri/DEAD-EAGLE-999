using System.Text.RegularExpressions;

public class PhoneNumber
{
    public static string Clean(string phoneNumber)
    {
        var justNumbers = string.Join("", phoneNumber.Where(char.IsDigit)).TrimStart('1');

        if (! Regex.IsMatch(justNumbers, @"^[2-9][0-9]{2}[2-9][0-9]{2}[0-9]{4}$"))
        {
            throw new ArgumentException("Invalid phone number");
        }
        
        return justNumbers;

    }
}