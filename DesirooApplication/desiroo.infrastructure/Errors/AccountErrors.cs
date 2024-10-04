using desiroo.core;

namespace desiroo.infrastructure.Errors;

public class AccountErrors
{
    public static readonly Error EmailNotFoundError = new(
        "EmailError", "Email was not found");

    public static readonly Error EmailOrPasswordIsEmptyError = new(
        "EmailOrPasswordIsEmptyError", "Email or Password must be complete");

    public static readonly Error EmailValidationError = new("EmailValidationError", "Email is invalid");

    public static readonly Error PasswordError = new(
        "PasswordError", "Incorrect Password");

    public static readonly Error PasswordValidationError = new(
        "PasswordValidationError", $"The password requires at least one letter," +
                                   $" one digit and one special character in the password," +
                                   $" as well as a minimum password length of 8 characters.");

    public static readonly Error AccountAlreadyExistError = new(
        "AccountAlreadyExistError", "Account already exist");

    public static readonly Error UserNotFoundError = new(
        "UserNotFoundError", "User not found");
}