using desiroo.core;
using desiroo.domain.Models;

namespace desiroo.application.Interfaces;

public interface IWishlistService
{
    public Task<ResultWith<List<Wishlist>>> GetOwnedWishlists(string accountId);
    public Task<ResultWith<List<Wishlist>>> GetSubscribedWishlists(string accountId);
    public Task<ResultWith<List<Product>>> GetWishlistItems(string wishlistId, string? searchName, string? filterPrice, string? filterImportance);

    public Task<ResultWith<Guid>> CreateWishlist(string name, string userId);
    public Task<ResultWith<Guid>> SubscribeToWishlist(string wishlistId);
    
    public Task<ResultWith<Product>> CreateProduct(string userId, string wishlistId, string name, string link, string priceCategory, 
        string giftImportance);
    public Task<Result> DeleteProduct(string userId, string productId);

    public Task<ResultWith<Product>> EditProduct(string userId, string wishlistId, string productId, string name, string link, string priceCategory,
        string giftImportance);
}