import 'package:bloc/bloc.dart';
import 'package:desiroo/features/wishlist/data/repository/wishlists_repository.dart';
import 'package:desiroo/features/wishlist/models/wishlist_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'wishlists_state.dart';

part 'wishlists_cubit.freezed.dart';

class WishlistsCubit extends Cubit<WishlistsState> {
  final WishlistsRepository repository;

  WishlistsCubit({required this.repository})
      : super(const WishlistsState.initial());

  getWishlists() async {
    emit(const WishlistsState.loading());

    final result = await repository.getWishlists();

    result.fold(
      (l) => emit(const WishlistsState.error('Create Your First Wishlist')),
      (r) => emit(WishlistsState.success(r)),
    );
  }

  createWishlist(String name) async {
    emit(const WishlistsState.loading());

    await repository.createWishlist(WishlistModel(Id: const Uuid().v4(), Name: name));

  }
}
