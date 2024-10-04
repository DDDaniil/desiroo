namespace desiroo.api.Models;

public record LoginCredentials(string Email, string Password);

public record RegisterCredentials(string Email, string Password);