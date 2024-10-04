import 'package:dartz/dartz.dart';
import 'package:desiroo/core/database/db_client.dart';
import 'package:desiroo/core/errors/failure.dart';
import 'package:desiroo/features/wishlist/data/data_sources/wishlist_local_data_source.dart';
import 'package:desiroo/features/wishlist/models/wishlist_model.dart';
import 'package:sqflite/sqflite.dart';

class WishlistLocalDataSourceImpl extends WishlistLocalDataSource {
  final DbClient dbClient;

  WishlistLocalDataSourceImpl({required this.dbClient});

  @override
  Future createWishlist(WishlistModel model) async {
    final db = await dbClient.database;

    await db.insert(
      'Wishlists',
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<Either<Failure, List<WishlistModel>>> getWishlists() async {
    final db = await dbClient.database;
    final List<Map<String, dynamic>> wishlists = await db.query('Wishlists');

    return wishlists.isNotEmpty
        ? Right(wishlists.map((c) => WishlistModel.fromJson(c)).toList())
        : Left(CacheFailure());
  }

  @override
  Future deleteWishlist(String id) async {
    final db = await dbClient.database;
    await db
        .delete('Wishlists', where: 'ID = ?', whereArgs: [id]);
  }

  @override
  Future editWishlist(WishlistModel model, String id) async {
    final db = await dbClient.database;
    await db
        .update('Wishlists', model.toJson(), where: 'ID = ?', whereArgs: [id]);
  }

  @override
  Future<Either<Failure, WishlistModel>> getWishlist(String id) async {
    final db = await dbClient.database;
    final List<Map<String, dynamic>> wishlists = await db
        .query('Wishlists', where: 'ID = ?', whereArgs: [id]);

    return wishlists.isNotEmpty
        ? Right(WishlistModel.fromJson(wishlists.first))
        : Left(CacheFailure());
  }
}