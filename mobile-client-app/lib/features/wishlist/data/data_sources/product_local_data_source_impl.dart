import 'package:dartz/dartz.dart';
import 'package:desiroo/core/database/db_client.dart';
import 'package:desiroo/core/errors/failure.dart';
import 'package:desiroo/features/wishlist/data/data_sources/product_local_data_source.dart';
import 'package:desiroo/features/wishlist/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductLocalDataSourceImpl extends ProductLocalDataSource {
  final DbClient dbClient;

  ProductLocalDataSourceImpl({required this.dbClient});

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts(String id) async {
    final db = await dbClient.database;
    final List<Map<String, dynamic>> products = await db
        .query('Products', where: 'WishlistId = ?', whereArgs: [id]);

    return products.isNotEmpty
        ? Right(products.map((p) => ProductModel.fromJson(p)).toList())
        : Left(CacheFailure());
  }

  @override
  Future<Either<Failure, ProductModel>> getProduct(String id) async {
    final db = await dbClient.database;
    final List<Map<String, dynamic>> products = await db
        .query('Products', where: 'ProductId = ?', whereArgs: [id]);

    return products.isNotEmpty
        ? Right(ProductModel.fromJson(products.first))
        : Left(CacheFailure());
  }

  @override
  Future createProduct(ProductModel product) async {
    final db = await dbClient.database;

    await db.insert(
      'Products',
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future deleteProduct(String id) async {
    final db = await dbClient.database;
    await db
        .delete('Products', where: 'ProductId = ?', whereArgs: [id]);
  }

  @override
  Future updateProduct(ProductModel product) async {
    final db = await dbClient.database;
    await db
        .update('Products', product.toJson(), where: 'ProductId = ?', whereArgs: [product.ProductId]);
  }
}