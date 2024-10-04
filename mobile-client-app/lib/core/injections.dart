import 'package:desiroo/core/database/db_client.dart';
import 'package:desiroo/features/wishlist/bloc/product_cubit.dart';
import 'package:desiroo/features/wishlist/bloc/products_cubit.dart';
import 'package:desiroo/features/wishlist/bloc/wishlist_cubit.dart';
import 'package:desiroo/features/wishlist/bloc/wishlists_cubit.dart';
import 'package:desiroo/features/wishlist/data/data_sources/product_local_data_source.dart';
import 'package:desiroo/features/wishlist/data/data_sources/product_local_data_source_impl.dart';
import 'package:desiroo/features/wishlist/data/data_sources/wishlist_local_data_source.dart';
import 'package:desiroo/features/wishlist/data/data_sources/wishlist_local_data_source_impl.dart';
import 'package:desiroo/features/wishlist/data/repository/products_repository.dart';
import 'package:desiroo/features/wishlist/data/repository/products_repository_impl.dart';
import 'package:desiroo/features/wishlist/data/repository/wishlists_repository.dart';
import 'package:desiroo/features/wishlist/data/repository/wishlists_repository_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<DbClient>(() => DbClient());

  getIt.registerLazySingleton<WishlistLocalDataSource>(
      () => WishlistLocalDataSourceImpl(
            dbClient: getIt(),
          ));
  getIt.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(
            dbClient: getIt(),
          ));
  getIt
      .registerLazySingleton<WishlistsRepository>(() => WishlistsRepositoryImpl(
            dataSource: getIt(),
          ));
  getIt.registerLazySingleton<ProductsRepository>(() => ProductsRepositoryImpl(
        dataSource: getIt(),
      ));
  getIt.registerLazySingleton(() => WishlistsCubit(
        repository: getIt(),
      ));
  getIt.registerLazySingleton(() => WishlistCubit(
        repository: getIt(),
      ));
  getIt.registerLazySingleton(() => ProductsCubit(
        repository: getIt(),
      ));
  getIt.registerLazySingleton(() => ProductCubit(
        repository: getIt(),
      ));
}
