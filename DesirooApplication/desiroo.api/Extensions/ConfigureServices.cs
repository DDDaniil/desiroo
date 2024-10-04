using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.Filters;

namespace desiroo.api.Extensions;

public static class ConfigureServices
{
    public static IServiceCollection AddSwaggerConfiguration(this IServiceCollection services) {
        services.AddSwaggerGen(options =>
        {
            options.AddSecurityDefinition("oauth2", new OpenApiSecurityScheme
            {
                In = ParameterLocation.Header,
                Scheme = JwtBearerDefaults.AuthenticationScheme,
                Name = "Authorization",
                Type = SecuritySchemeType.Http
            });
    
            options.OperationFilter<SecurityRequirementsOperationFilter>();
        });

        return services;
    }
}