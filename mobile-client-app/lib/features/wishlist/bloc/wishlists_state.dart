part of 'wishlists_cubit.dart';

@freezed
class WishlistsState with _$WishlistsState {
  const factory WishlistsState.initial() = _Initial;
  const factory WishlistsState.loading() = _Loading;
  const factory WishlistsState.success(List<WishlistModel> wishlists) = _Success;
  const factory WishlistsState.error(String error) = _Error;
}
