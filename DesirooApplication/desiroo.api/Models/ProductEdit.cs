namespace desiroo.api.Models;

public record ProductEdit(string WishlistId, string ProductId, string Name, string Link, string PriceCategory, string GiftImportance, IFormFile Photo);