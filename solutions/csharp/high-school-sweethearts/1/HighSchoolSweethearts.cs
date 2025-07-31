// Dedicated to Shree DR.MDD
using System;
using System.Globalization;

public static class HighSchoolSweethearts
{
    public static string DisplaySingleLine(string firstName, string secondName)
    {
        const int alignment = (61 - 3) / 2;
        return $"{firstName,alignment} ♡ {secondName,-alignment}";
    }

    public static string DisplayBanner(string firstName, string secondName)
    {
        return $@"******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
** {firstName, 10} +  {secondName, -9} **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *";
    }

    public static string DisplayGermanExchangeStudents(string partnerOne, string partnerTwo, DateTime initiatedOn, float durationHours) =>
        string.Format(CultureInfo.GetCultureInfo("de-DE"), "{0} and {1} have been dating since {2:d} - that's {3:N2} hours", partnerOne, partnerTwo, initiatedOn.Date, durationHours);
}
