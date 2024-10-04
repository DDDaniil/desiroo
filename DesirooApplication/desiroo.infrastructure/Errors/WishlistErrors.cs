using desiroo.core;

namespace desiroo.infrastructure.Errors;

public class WishlistErrors
{
    public static readonly Error WishlistNotFoundError = new(
        "WishlistError", "Wishlist was not found");
    public static readonly Error ProductNotFoundError = new(
        "ProductError", "Product was not found");
    public static readonly Error PhotoNotUploadedError = new(
        "ProductError", "Photo was not uploaded");
    public static readonly Error PhotoUploadError = new(
        "ProductError", "Failed to upload photo");
}