namespace desiroo.domain.Models;

public class Product
{
    public Guid ProductId { get; set; }
    public string Name { get; set; }
    public string Link { get; set; }
    public string PriceCategory { get; set; }
    public string GiftImportance { get; set; }
    
    public Guid WishlistId { get; set; }
    public Wishlist Wishlist { get; set; }
}