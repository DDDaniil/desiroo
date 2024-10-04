import 'package:desiroo/core/constants/styled_constants.dart';
import 'dart:math';

import 'package:desiroo/core/widgets/styled_filter_dropdown.dart';
import 'package:desiroo/features/wishlist/bloc/products_cubit.dart';
import 'package:desiroo/features/wishlist/bloc/wishlist_cubit.dart';
import 'package:desiroo/features/wishlist/widgets/styled_product_card.dart';
import 'package:desiroo/core/widgets/styled_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({
    super.key,
    this.wishlistId,
  });

  final String? wishlistId;

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    context.read<WishlistCubit>().getWishlist(widget.wishlistId ?? '');
    context.read<ProductsCubit>().getProducts(widget.wishlistId ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          return state.when(
              initial: SizedBox.shrink,
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
              success: (wishlist) => Column(
                    children: [
                      SizedBox(
                        height: 68,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 60),
                              child: Text(
                                wishlist.Name,
                                style: StyledConstants.headerTextStyle,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  GoRouter.of(context).push(
                                      '/editWishlist/${widget.wishlistId}',
                                    extra: wishlist,
                                  );
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        ),
                      ),
                      Expanded(
                        child: NestedScrollView(
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              SliverAppBar(
                                toolbarHeight: 0,
                                expandedHeight: 320,
                                collapsedHeight: 0,
                                flexibleSpace: FlexibleSpaceBar(
                                  background: Stack(children: [
                                    SizedBox(
                                      height: 320,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            transform: GradientRotation(
                                                Random().nextInt(180) * pi / 180),
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color((Random().nextDouble() * 0xFFFFAF).toInt())
                                                  .withOpacity(.4),
                                              Color((Random().nextDouble() * 0xFFFFAF).toInt())
                                                  .withOpacity(.4)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 320,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Colors.black87
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: [0.6, 1],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  titlePadding: const EdgeInsets.only(
                                      left: 20, bottom: 20),
                                  title: Text(
                                    wishlist.Name,
                                    style: StyledConstants.headerTextStyle2
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                pinned: true,
                                //floating: true,
                                //forceElevated: innerBoxIsScrolled,
                              ),
                            ];
                          },
                          body: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: StyledConstants.edgeInsetsVertical,
                                horizontal:
                                    StyledConstants.edgeInsetsHorizontal),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 120,
                                  child: Column(
                                    children: [
                                      const StyledSearchTextField(
                                          placeholder:
                                              'Search for the products'),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12, bottom: 12),
                                        child: Row(
                                          children: [
                                            Flexible(
                                                child: StyledFilterDropdown(
                                              dropdownValue: 'Low',
                                              onDropdownChanged: () {},
                                            )),
                                            const SizedBox(width: 6),
                                            Flexible(
                                                child: StyledFilterDropdown(
                                              dropdownValue: 'Low',
                                              onDropdownChanged: () {},
                                            )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: BlocBuilder<ProductsCubit, ProductsState>(
                                    builder: (context, state) {
                                      return state.when(
                                          initial: () => const SizedBox.shrink(),
                                          loading: () => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          success: (products) => ListView.builder(
                                            itemCount: products.length,
                                            itemBuilder: (context, index) {
                                              return StyledProductCard(
                                                  name: products[index].Name,
                                                  importance:products[index].GiftImportance,
                                                  price: products[index].PriceCategory,
                                                  photoPath: products[index].PhotoPath,
                                                  onTap: () {
                                                    context.push('/updateProduct/${widget.wishlistId}', extra: products[index]);
                                                  },
                                              );
                                            },
                                          ),
                                          error: (message) => Center(child: Text(message))
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              error: (message) => Text(message));
        },
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).push('/createProduct/${widget.wishlistId}');
          },
          tooltip: 'Add product',
          child: const Icon(Icons.add)),
    );
  }
}
