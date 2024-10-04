import 'package:dartz/dartz.dart';
import 'package:desiroo/core/errors/failure.dart';
import 'package:desiroo/features/wishlist/models/wishlist_model.dart';

abstract class WishlistsRepository {
  Future createWishlist(WishlistModel wishlist);
  Future<Either<Failure, List<WishlistModel>>> getWishlists();
  Future<Either<Failure, WishlistModel>> getWishlist(String id);
  Future editWishlist(WishlistModel wishlist, String id);
  Future deleteWishlist(String id);
}