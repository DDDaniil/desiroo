import 'package:desiroo/core/widgets/layout/scaffold_with_bottom_bar.dart';
import 'package:desiroo/core/widgets/layout/sidebar_layout.dart';
import 'package:desiroo/features/auth/presentation/pages/login_page.dart';
import 'package:desiroo/features/auth/presentation/pages/registration_page.dart';
import 'package:desiroo/features/wishlist/models/product_model.dart';
import 'package:desiroo/features/wishlist/models/wishlist_model.dart';
import 'package:desiroo/features/wishlist/presentation/pages/create_product_page.dart';
import 'package:desiroo/features/wishlist/presentation/pages/create_wishlist_page.dart';
import 'package:desiroo/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:desiroo/home_page.dart';
import 'package:desiroo/features/wishlist/presentation/pages/wishlists_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final publicRoutes = GoRouter(
  routes: <RouteBase>[
    ShellRoute(
      builder: (
        BuildContext context,
        GoRouterState state,
        Widget child,
      ) {
        return ScaffoldWithBottomBar(state: state, child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const MyHomePage(title: 'Desiroo');
          },
        ),
        GoRoute(
            path: '/wishlists',
            builder: (BuildContext context, GoRouterState state) {
              return const WishlistsPage();
            },
        ),
      ],
    ),
    ShellRoute(
        builder: (
          BuildContext context,
          GoRouterState state,
          Widget child,
        ) {
          return SidebarLayout(child: child);
        },
        routes: [
          GoRoute(
              path: '/wishlist/:id',
              builder: (BuildContext context, GoRouterState state) {
                return WishlistPage(
                  wishlistId: state.pathParameters['id'],
                );
              },
          ),
          GoRoute(
            path: '/createProduct/:id',
            builder: (BuildContext context, GoRouterState state) {
              return CreateProductPage(
                wishlistId: state.pathParameters['id'],
              );
            },
          ),
          GoRoute(
            path: '/updateProduct/:id',
            builder: (BuildContext context, GoRouterState state) {
              return CreateProductPage(
                wishlistId: state.pathParameters['id'],
                product: state.extra! as ProductModel,
              );
            },
          ),
          GoRoute(
            path: '/createWishlist',
            builder: (BuildContext context, GoRouterState state) {
              return const CreateWishlistPage();
            },
          ),
          GoRoute(
            path: '/editWishlist/:id',
            builder: (BuildContext context, GoRouterState state) {
              return CreateWishlistPage(
                id: state.pathParameters['id'],
                wishlist: state.extra! as WishlistModel,
              );
            },
          ),
        ]),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: '/registration',
      builder: (BuildContext context, GoRouterState state) {
        return const RegistrationPage();
      },
    ),
  ],
);
