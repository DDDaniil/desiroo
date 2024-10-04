part of 'products_cubit.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;
  const factory ProductsState.loading() = _loading;
  const factory ProductsState.success(List<ProductModel> wishlists) = _Success;
  const factory ProductsState.error(String error) = _Error;
}
