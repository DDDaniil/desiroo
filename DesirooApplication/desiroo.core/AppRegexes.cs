using System.Text.RegularExpressions;

namespace desiroo.core;

public static class AppRegexes
{
    public static readonly Regex EmailRegex = new Regex(
        @"^[^@\s]+@[^@\s]+\.[a-zA-Z]{2,5}$");
    
    public static readonly Regex PasswordRegex = new Regex(
        @"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?])[A-Za-z\d@$!%*?]{8,}$");
}