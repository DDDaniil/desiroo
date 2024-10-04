using Microsoft.AspNetCore.Identity;

namespace desiroo.domain.Models;

public class Account : IdentityUser
{
    public ICollection<AccountWishlist> Wishlists { get; set; } = [];
}