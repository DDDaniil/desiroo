import 'package:dartz/dartz.dart';
import 'package:desiroo/core/errors/failure.dart';
import 'package:desiroo/features/wishlist/models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<Either<Failure, List<ProductModel>>> getProducts(String id);
  Future<Either<Failure, ProductModel>> getProduct(String id);
  Future createProduct(ProductModel product);
  Future deleteProduct(String id);
  Future updateProduct(ProductModel product);

}