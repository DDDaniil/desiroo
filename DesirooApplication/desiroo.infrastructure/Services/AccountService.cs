using desiroo.application.Interfaces;
using desiroo.core;
using desiroo.domain.Models;
using desiroo.infrastructure.Errors;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;

namespace desiroo.infrastructure.Services;

public class AccountService(UserManager<Account> userManager) : IAccountService
{
    public async Task<Result> CreateUserAccount(string email, string password)
    {
        var account = await userManager.FindByEmailAsync(email);

        if (account != null)
        {
            return Result.Failure(AccountErrors.AccountAlreadyExistError);
        }
        
        account = new Account
        {
            Email = email,
            UserName = email,
        };
        var result = await userManager.CreateAsync(account, password);
        if (!result.Succeeded)
        {
            return Result.Failure(AccountErrors.AccountAlreadyExistError);
        }

        return Result.Success();
    }

    public async Task<ResultWith<string>> AuthorizeUser(string email, string password)
    {
        var account = await userManager.FindByEmailAsync(email);
        if (account == null)
        {
            return ResultWith<string>.Failure(AccountErrors.EmailNotFoundError);
        }
        
        var passwordValid = await userManager.CheckPasswordAsync(account, password);
        if (!passwordValid)
        {
            return ResultWith<string>.Failure(AccountErrors.PasswordError);
        }

        return ResultWith<string>.Success(account.Id);
    }

    public Result ValidateCredentials(string email, string password)
    {
        if (email.IsNullOrEmpty() || password.IsNullOrEmpty())
        {
            return Result.Failure(AccountErrors.EmailOrPasswordIsEmptyError);
        }

        if (!AppRegexes.EmailRegex.IsMatch(email))
        {
            return Result.Failure(AccountErrors.EmailValidationError);
        }

        if (!AppRegexes.PasswordRegex.IsMatch(password))
        {
            return Result.Failure(AccountErrors.PasswordValidationError);
        }

        return Result.Success();
    }
}