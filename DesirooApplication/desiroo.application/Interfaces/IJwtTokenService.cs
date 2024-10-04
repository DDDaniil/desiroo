namespace desiroo.application.Interfaces;

public interface IJwtTokenService
{
    public string CreateToken(string email,  string userId);
    public string RefreshToken(string token);
}