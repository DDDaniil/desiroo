import 'package:bloc/bloc.dart';
import 'package:desiroo/features/wishlist/data/repository/products_repository.dart';
import 'package:desiroo/features/wishlist/models/product_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_state.dart';
part 'products_cubit.freezed.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository repository;

  ProductsCubit({required this.repository})
      : super(const ProductsState.initial());

  getProducts(String id) async {
    emit(const ProductsState.loading());

    final result = await repository.getProducts(id);

    result.fold(
        (l) => emit(const ProductsState.error('Add Your First Wish')),
        (r) => emit(ProductsState.success(r)),
    );
  }
}
