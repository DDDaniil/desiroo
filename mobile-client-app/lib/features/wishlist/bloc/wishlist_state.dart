part of 'wishlist_cubit.dart';

@freezed
class WishlistState with _$WishlistState {
  const factory WishlistState.initial() = _Initial;
  const factory WishlistState.loading() = _Loading;
  const factory WishlistState.success(WishlistModel wishlist) = _Success;
  const factory WishlistState.error(String error) = _Error;
}
