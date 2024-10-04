using desiroo.domain.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace desiroo.infrastructure;

public class DesirooContext : IdentityDbContext<Account>
{
    public DbSet<Wishlist> Wishlists { get; set; }
    public DbSet<AccountWishlist> AccountWishlists { get; set; }
    public DbSet<Product> Products { get; set; }
    
    public DesirooContext(DbContextOptions<DesirooContext> options) : base(options)
    {
        
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);
        // DataSeed by https://github.com/SalavatKhR
        
        var user1 = new Account {Email = "user1@email.com"};
        var user2 = new Account {Email = "user2@email.com"};
        var user3 = new Account {Email = "user3@email.com"};
        
        var password = "qWe!1234";
        
        var passwordHash1 = new PasswordHasher<Account>()
            .HashPassword(user1, password);
        var passwordHash2 = new PasswordHasher<Account>()
            .HashPassword(user2, password);
        var passwordHash3 = new PasswordHasher<Account>()
            .HashPassword(user3, password);
        user1.PasswordHash = passwordHash1;
        user2.PasswordHash = passwordHash2;
        user3.PasswordHash = passwordHash3;
        user1.NormalizedEmail = user1.Email.ToUpper();
        user2.NormalizedEmail = user2.Email.ToUpper();
        user3.NormalizedEmail = user3.Email.ToUpper();

        builder.Entity<Account>().HasData(user1, user2, user3);
        
        var wishlist1 = new Wishlist() {Id = Guid.NewGuid(), Name = "user1 wishlist"};
        var wishlist2 = new Wishlist() {Id = Guid.NewGuid(), Name = "user2 wishlist"};
        var wishlist3 = new Wishlist() {Id = Guid.NewGuid(), Name = "user3 wishlist"};

        builder.Entity<Wishlist>().HasData(wishlist1, wishlist2, wishlist3);
        
        var accountWishlist1 = new AccountWishlist()
        {
            AccountId = user1.Id,
            WishlistId = wishlist1.Id,
            IsOwner = true
        };
        
        var accountWishlist2 = new AccountWishlist()
        {
            AccountId = user2.Id,
            WishlistId = wishlist2.Id,
            IsOwner = true
        };
        
        var accountWishlist3 = new AccountWishlist()
        {
            AccountId = user3.Id,
            WishlistId = wishlist3.Id,
            IsOwner = true
        };

        builder.Entity<AccountWishlist>().HasData(accountWishlist1, accountWishlist2, accountWishlist3);
        
        var sub1 = new AccountWishlist()
        {
            AccountId = user1.Id,
            WishlistId = wishlist2.Id,
            IsOwner = false
        };
        var sub2 = new AccountWishlist()
        {
            AccountId = user1.Id,
            WishlistId = wishlist3.Id,
            IsOwner = false
        };

        builder.Entity<AccountWishlist>().HasData(sub1, sub2);
    }
} //Из папки с api  => dotnet ef migrations add Initial -p ..\desiroo.infrastructure\