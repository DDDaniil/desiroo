using desiroo.application.Interfaces;
using desiroo.core;
using desiroo.domain.Models;
using desiroo.infrastructure.Errors;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace desiroo.infrastructure.Services;

public class WishlistService(
    DesirooContext desirooContext,
    UserManager<Account> userManager)
    : IWishlistService
{
    public async Task<ResultWith<List<Wishlist>>> GetOwnedWishlists(string accountId)
    {
        //TODO: убрать список подписчиков из ответа
        var wishlists = await desirooContext.AccountWishlists
            .Where(aw => aw.Account.Id == accountId && aw.IsOwner)
            .Select(aw => aw.Wishlist)
            .ToListAsync();

        return ResultWith<List<Wishlist>>.Success(wishlists);
    }

    public async Task<ResultWith<List<Wishlist>>> GetSubscribedWishlists(string accountId)
    {
        //TODO: убрать список подписчиков из ответа
        var wishlists = await desirooContext.AccountWishlists
            .Where(aw => aw.Account.Id == accountId && !aw.IsOwner)
            .Select(aw => aw.Wishlist)
            .ToListAsync();

        return ResultWith<List<Wishlist>>.Success(wishlists);
    }

    public async Task<ResultWith<List<Product>>> GetWishlistItems(string wishlistId, string? searchName, 
        string? filterPrice, string? filterImportance)
    {
        if (searchName != null)
        {
            if (filterPrice != null && filterImportance != null)
            {
                var productsFilterAll = await desirooContext.Products
                    .Where(x => x.WishlistId == new Guid(wishlistId))
                    .Where(x => x.Name.Contains(searchName))
                    .Where(y => y.PriceCategory == filterPrice)
                    .Where(u => u.GiftImportance == filterImportance)
                    .ToListAsync();
            
                return ResultWith<List<Product>>.Success(productsFilterAll);
            }
            
            if (filterPrice != null)
            {
                var productsFilterNamePrice = await desirooContext.Products
                    .Where(x => x.WishlistId == new Guid(wishlistId))
                    .Where(x => x.Name.Contains(searchName))
                    .Where(y => y.PriceCategory == filterPrice)
                    .ToListAsync();
            
                return ResultWith<List<Product>>.Success(productsFilterNamePrice);
            }

            if (filterImportance != null)
            {
                var productsFilterNameImp = await desirooContext.Products
                    .Where(x => x.WishlistId == new Guid(wishlistId))
                    .Where(x => x.Name.Contains(searchName))
                    .Where(u => u.GiftImportance == filterImportance)
                    .ToListAsync();
            
                return ResultWith<List<Product>>.Success(productsFilterNameImp);
            }
            
            
            var productsFilterName = await desirooContext.Products
                .Where(x => x.WishlistId == new Guid(wishlistId))
                .Where(x => x.Name.Contains(searchName))
                .ToListAsync();
            
            return ResultWith<List<Product>>.Success(productsFilterName);
        }
        else
        {
            if (filterPrice != null && filterImportance != null)
            {
                var productsFilterAll = await desirooContext.Products
                    .Where(x => x.WishlistId == new Guid(wishlistId))
                    .Where(y => y.PriceCategory == filterPrice)
                    .Where(u => u.GiftImportance == filterImportance)
                    .ToListAsync();
            
                return ResultWith<List<Product>>.Success(productsFilterAll);
            }
            
            if (filterPrice != null)
            {
                var productsFilterNamePrice = await desirooContext.Products
                    .Where(x => x.WishlistId == new Guid(wishlistId))
                    .Where(y => y.PriceCategory == filterPrice)
                    .ToListAsync();
            
                return ResultWith<List<Product>>.Success(productsFilterNamePrice);
            }

            if (filterImportance != null)
            {
                var productsFilterImp = await desirooContext.Products
                    .Where(x => x.WishlistId == new Guid(wishlistId))
                    .Where(u => u.GiftImportance == filterImportance)
                    .ToListAsync();
            
                return ResultWith<List<Product>>.Success(productsFilterImp);
            }
            
        }
        
        var productsNoFilter = await desirooContext.Products
            .Where(x => x.WishlistId == new Guid(wishlistId))
            .ToListAsync();

        return ResultWith<List<Product>>.Success(productsNoFilter);
    }
    
    public async Task<ResultWith<Guid>> CreateWishlist(string name, string userId)
    {
        var user = await userManager.FindByIdAsync(userId);

        if (user == null)
        {
            return ResultWith<Guid>.Failure(AccountErrors.UserNotFoundError);
        }
        
        var wishlist = new Wishlist()
        {
            Name = name,
        };

        var newAccountWishlist = new AccountWishlist()
        {
            Account = user,
            Wishlist = wishlist,
            IsOwner = true
        };

        var result = desirooContext.AccountWishlists.Add(newAccountWishlist);
        await desirooContext.SaveChangesAsync();

        return ResultWith<Guid>.Success(result.Entity.Wishlist.Id);
    }

    public Task<ResultWith<Guid>> SubscribeToWishlist(string wishlistId)
    {
        throw new NotImplementedException();
    }

    public async Task<ResultWith<Product>> CreateProduct(string userId, string wishlistId, string name, string link, string priceCategory,
        string giftImportance)
    {
        var user = await userManager.FindByIdAsync(userId);

        if (user == null)
        {
            return ResultWith<Product>.Failure(AccountErrors.UserNotFoundError);
        }

        var wishlist = await desirooContext.Wishlists
            .FirstOrDefaultAsync(s => s.Id == new Guid(wishlistId));

        if (wishlist == null)
        {
            return ResultWith<Product>.Failure(WishlistErrors.WishlistNotFoundError);
        }
        
        var product = new Product()
        {
            Name = name,
            Link = link,
            PriceCategory = priceCategory,
            GiftImportance = giftImportance,
            Wishlist = wishlist,
        };

        var result = await desirooContext.Products.AddAsync(product);

        await desirooContext.SaveChangesAsync();

        return ResultWith<Product>.Success(result.Entity);
    }

    public async Task<Result> DeleteProduct(string userId, string productId)
    {
        var user = await userManager.FindByIdAsync(userId);

        if (user == null)
        {
            return Result.Failure(AccountErrors.UserNotFoundError);
        }

        var product = await desirooContext.Products
            .FirstOrDefaultAsync(s => s.ProductId == new Guid(productId));

        if (product == null)
        {
            return Result.Failure(WishlistErrors.ProductNotFoundError);
        }

        desirooContext.Products.Remove(product);

        await desirooContext.SaveChangesAsync();

        return Result.Success();
    }
    
    public async Task<ResultWith<Product>> EditProduct(string userId, string wishlistId, string productId, string name, string link, string priceCategory,
        string giftImportance)
    {
        var user = await userManager.FindByIdAsync(userId);

        if (user == null)
        {
            return ResultWith<Product>.Failure(AccountErrors.UserNotFoundError);
        }

        var wishlist = await desirooContext.Wishlists
            .FirstOrDefaultAsync(s => s.Id == new Guid(wishlistId));

        if (wishlist == null)
        {
            return ResultWith<Product>.Failure(WishlistErrors.WishlistNotFoundError);
        }
        
        var product = new Product()
        {
            Name = name,
            Link = link,
            PriceCategory = priceCategory,
            GiftImportance = giftImportance,
            Wishlist = wishlist,
            ProductId = new Guid(productId),
        };

        desirooContext.Products.Update(product);

        await desirooContext.SaveChangesAsync();

        return ResultWith<Product>.Success(product);
    }
}