import 'package:desiroo/core/constants/styled_constants.dart';
import 'package:desiroo/features/wishlist/bloc/wishlists_cubit.dart';
import 'package:desiroo/features/wishlist/presentation/enums/wishlist_tabs.dart';
import 'package:desiroo/features/wishlist/widgets/tabs_selector.dart';
import 'package:desiroo/features/wishlist/widgets/wishlist_grid.dart';
import 'package:desiroo/features/wishlist/widgets/wishlist_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WishlistsPage extends StatefulWidget {
  const WishlistsPage({super.key});

  @override
  State<WishlistsPage> createState() => _WishlistsPageState();
}

class _WishlistsPageState extends State<WishlistsPage> {
  WishlistTabs currentTab = WishlistTabs.your;

  @override
  void initState() {
    super.initState();
    context.read<WishlistsCubit>().getWishlists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: StyledConstants.edgeInsetsHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 68,
                padding: const EdgeInsets.only(left: 40),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Wishlists',
                  style: StyledConstants.headerTextStyle,
                ),
              ),
              SizedBox(
                child: TabsSelector(
                  onChange: (index) {
                    context.read<WishlistsCubit>().getWishlists();
                    setState(() {
                      currentTab = WishlistTabs.values[index];
                    });
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<WishlistsCubit, WishlistsState>(
                  builder: (context, state) {
                    return state.when(
                        initial: () => const SizedBox.shrink(),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        success: (wishlists) => currentTab == WishlistTabs.your
                            ? WishlistsGrid(
                                items: wishlists.map((wishlist) {
                                return WishlistGridItem(
                                  name: wishlist.Name,
                                  onTap: () {
                                    context.push('/wishlist/${wishlist.Id}');
                                  },
                                );
                              }).toList())
                            : const Center(
                                child: Text('No Internet Connection')),
                        error: (message) => Center(child: Text(message)));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).push('/createWishlist');
          },
          tooltip: 'Add wishlist',
          child: const Icon(Icons.add)),
    );
  }
}
