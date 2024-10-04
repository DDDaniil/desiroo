using desiroo.core;

namespace desiroo.application.Interfaces;

public interface IAccountService
{
    public Task<Result> CreateUserAccount(string email, string password);
    public Task<ResultWith<string>> AuthorizeUser(string email, string password);

    public Result ValidateCredentials(string email, string password);
}