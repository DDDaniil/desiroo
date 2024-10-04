import 'package:bloc/bloc.dart';
import 'package:desiroo/features/wishlist/data/repository/products_repository.dart';
import 'package:desiroo/features/wishlist/models/product_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_state.dart';
part 'product_cubit.freezed.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductsRepository repository;

  ProductCubit({required this.repository})
      : super(const ProductState.initial());

  getProduct(String id) async {
    emit(const ProductState.loading());

    final product = await repository.getProduct(id);

    product.fold(
        (error) => emit(const ProductState.error('Product loading error')),
        (data) => emit(ProductState.success(data)),
    );
  }

  createProduct(ProductModel product) async {
    emit(const ProductState.loading());

    await repository.createProduct(product);
  }

  updateProduct(ProductModel product) async {
    emit(const ProductState.loading());

    await repository.updateProduct(product);
  }

  deleteProduct(id) async {
    emit(const ProductState.loading());

    await repository.deleteProduct(id);
  }



}
