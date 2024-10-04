using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using desiroo.application.Interfaces;
using desiroo.core;
using Microsoft.IdentityModel.Tokens;

namespace desiroo.infrastructure.Services;

public class JwtTokenService(JwtOptions jwtOptions) : IJwtTokenService
{
    public string CreateToken(string email, string userId)
    {
        var claims = new Claim[]
        {
            new ("userEmail", email),
            new ("userId", userId),
        };
        
        var signingKeyBytes = Encoding.UTF8
            .GetBytes(jwtOptions.SigningKey);

        var signingCredentials = new SigningCredentials(
            new SymmetricSecurityKey(signingKeyBytes), SecurityAlgorithms.HmacSha256);

        var token = new JwtSecurityToken(
            jwtOptions.Issuer,
            jwtOptions.Audience,
            claims,
            DateTime.Now,
            DateTime.Now.AddSeconds(jwtOptions.ExpirationSeconds),
            signingCredentials);

        return  new JwtSecurityTokenHandler().WriteToken(token);
    }

    public string RefreshToken(string token)
    {
        throw new NotImplementedException();
    }
}