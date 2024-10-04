import 'package:dartz/dartz.dart';
import 'package:desiroo/core/errors/failure.dart';
import 'package:desiroo/features/wishlist/data/data_sources/product_local_data_source.dart';
import 'package:desiroo/features/wishlist/data/repository/products_repository.dart';
import 'package:desiroo/features/wishlist/models/product_model.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductLocalDataSource dataSource;

  ProductsRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts(String id) async {
    final result = await dataSource.getProducts(id);
    return result.fold(
          (l) => Left(l),
          (r) => Right(r),
    );
  }

  @override
  Future<Either<Failure, ProductModel>> getProduct(String id) async {
    final result = await dataSource.getProduct(id);
    return result.fold(
          (l) => Left(l),
          (r) => Right(r),
    );
  }

  @override
  Future createProduct(ProductModel product) async {
    await dataSource.createProduct(product);
  }

  @override
  Future deleteProduct(String id) async {
    await dataSource.deleteProduct(id);
  }

  @override
  Future updateProduct(ProductModel product) async {
    await dataSource.updateProduct(product);
  }



}