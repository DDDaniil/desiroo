using Microsoft.EntityFrameworkCore;

namespace desiroo.domain.Models;

[PrimaryKey("WishlistId", "AccountId")]
public class AccountWishlist
{
    public Guid WishlistId { get; set; }
    public string AccountId { get; set; }
    public Wishlist Wishlist { get; set; } = null!;
    public Account Account { get; set; } = null!;
    public bool IsOwner { get; set; }
}