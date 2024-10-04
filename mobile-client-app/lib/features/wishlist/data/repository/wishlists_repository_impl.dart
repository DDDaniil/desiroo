import 'package:dartz/dartz.dart';
import 'package:desiroo/core/errors/failure.dart';
import 'package:desiroo/features/wishlist/data/data_sources/wishlist_local_data_source.dart';
import 'package:desiroo/features/wishlist/data/repository/wishlists_repository.dart';
import 'package:desiroo/features/wishlist/models/wishlist_model.dart';

class WishlistsRepositoryImpl extends WishlistsRepository {
  final WishlistLocalDataSource dataSource;

  WishlistsRepositoryImpl({required this.dataSource});

  @override
  Future createWishlist(WishlistModel wishlist) async {
    await dataSource.createWishlist(wishlist);
  }

  @override
  Future<Either<Failure, List<WishlistModel>>> getWishlists() async {
    final result = await dataSource.getWishlists();
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }

  @override
  Future deleteWishlist(String id) async {
    await dataSource.deleteWishlist(id);
  }

  @override
  Future editWishlist(WishlistModel wishlist, String id) async {
    await dataSource.editWishlist(wishlist, id);
  }

  @override
  Future<Either<Failure, WishlistModel>> getWishlist(String id) async {
    final result = await dataSource.getWishlist(id);
    return result.fold(
          (l) => Left(l),
          (r) => Right(r),
    );
  }
}
