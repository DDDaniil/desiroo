import 'package:dartz/dartz.dart';
import 'package:desiroo/core/errors/failure.dart';
import 'package:desiroo/features/wishlist/models/wishlist_model.dart';

abstract class WishlistLocalDataSource {
  Future createWishlist(WishlistModel model);
  Future<Either<Failure, List<WishlistModel>>> getWishlists();
  Future<Either<Failure, WishlistModel>> getWishlist(String id);
  Future editWishlist(WishlistModel model, String id);
  Future deleteWishlist(String id);
}