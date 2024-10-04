namespace desiroo.domain.Models;

public class Wishlist
{
    public Guid Id { get; set; }
    public String Name { get; set; } = null!;
    
    public ICollection<AccountWishlist> Subscribers { get; set; } = [];
    public ICollection<Product> Products { get; set; } = [];
}