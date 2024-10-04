using System.Configuration;
using System.Text;
using desiroo.application.Interfaces;
using desiroo.core;
using desiroo.domain.Models;
using desiroo.infrastructure.Services;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Minio;

namespace desiroo.infrastructure;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddServices(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddSingleton(GetJwtOptions(configuration));
        services.AddScoped<IJwtTokenService, JwtTokenService>();
        services.AddScoped<IAccountService, AccountService>();
        services.AddScoped<IWishlistService, WishlistService>();

        return services;
    }
    
    public static IServiceCollection AddInfrastructure(this IServiceCollection services,
        IConfiguration configuration)
    {
        services.AddSingleton<MinioClient>(_ =>
        {
            var minioClient = new MinioClient()
                .WithEndpoint(configuration["MinioConfig:Endpoint"])
                .WithCredentials(configuration["MinioConfig:AccessKey"],
                    configuration["MinioConfig:SecretKey"])
                .Build();

            return (MinioClient) minioClient;
        });

        services.AddDbContext<DesirooContext>(options =>
            options.UseNpgsql(configuration.GetConnectionString("DefaultConnection")));

        return services;
    }

    public static IServiceCollection AddAccessControlGroup(this IServiceCollection services,
        IConfiguration configuration)
    {
        services.AddCors(option =>
        {
            option.AddDefaultPolicy(policy =>
            {
                policy
                    .WithOrigins(configuration["ClientUrl"] ?? string.Empty)
                    .AllowAnyHeader()
                    .AllowAnyMethod();
            });
        });

        var jwtOptions = GetJwtOptions(configuration);

        services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
            .AddJwtBearer(opts =>
            {
                byte[] signingKeyBytes = Encoding.UTF8
                    .GetBytes(jwtOptions.SigningKey);

                opts.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = false,
                    ValidateAudience = false,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true,
                    ValidIssuer = jwtOptions.Issuer,
                    ValidAudience = jwtOptions.Audience,
                    IssuerSigningKey = new SymmetricSecurityKey(signingKeyBytes)
                };
            });
        services.AddAuthorization();

        return services;
    }

    public static IServiceCollection AddIdentityConfiguration(this IServiceCollection services)
    {
        services.AddIdentityCore<Account>()
            .AddEntityFrameworkStores<DesirooContext>()
            .AddUserManager<UserManager<Account>>();

        return services;
    }

    private static JwtOptions GetJwtOptions(IConfiguration configuration)
    {
        return configuration
            .GetSection("JwtOptions")
            .Get<JwtOptions>() ?? throw new SettingsPropertyNotFoundException();
    }
}