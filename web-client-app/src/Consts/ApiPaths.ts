export const ApiBaseRoot = 'http://localhost:5177/api';

export const ApiPaths = {
    Home: `${ApiBaseRoot}/`,
    Register: `${ApiBaseRoot}/Account/register`,
    Login: `${ApiBaseRoot}/Account/login`,
    CreateProduct: `${ApiBaseRoot}/Wishlist/CreateProduct`,
    EditProduct: `${ApiBaseRoot}/Wishlist/EditProduct`,
    DeleteProduct: `${ApiBaseRoot}/Wishlist/DeleteProduct`,
    GetSubscribedWishlists: `${ApiBaseRoot}/Wishlist/GetSubscribedWishlists`,
    GetMyWishlists: `${ApiBaseRoot}/Wishlist/GetMyWishlists`,
    GetWishlistItems: `${ApiBaseRoot}/Wishlist/GetWishlistItems`,
}