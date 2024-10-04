import 'package:bloc/bloc.dart';
import 'package:desiroo/features/wishlist/data/repository/wishlists_repository.dart';
import 'package:desiroo/features/wishlist/models/wishlist_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_state.dart';

part 'wishlist_cubit.freezed.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistsRepository repository;

  WishlistCubit({required this.repository})
      : super(const WishlistState.initial());

  getWishlist(String id) async {
    emit(const WishlistState.loading());

    final wishlist = await repository.getWishlist(id);

    wishlist.fold(
      (wishlistError) =>
          emit(const WishlistState.error('Wishlists loading error')),
      (wishlistInfo) => emit(WishlistState.success(wishlistInfo)),
    );
  }

  editWishlist(name, id) async {
    emit(const WishlistState.loading());

    final wishlist = WishlistModel(Id: id, Name: name);

    await repository.editWishlist(wishlist, id);
  }

  deleteWishlist(id) async {
    emit(const WishlistState.loading());

    await repository.deleteWishlist(id);
  }
}
