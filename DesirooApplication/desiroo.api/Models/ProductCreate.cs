namespace desiroo.api.Models;

public record ProductCreate(string WishlistId, string Name, string Link, string PriceCategory, string GiftImportance, IFormFile Photo);
