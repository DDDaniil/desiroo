import 'package:desiroo/features/wishlist/widgets/wishlist_grid_item.dart';
import 'package:flutter/material.dart';

class WishlistsGrid extends StatelessWidget {
  const WishlistsGrid({super.key, required this.items});

  final List<WishlistGridItem> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 10,
        childAspectRatio: 0.83,
        crossAxisCount: 2,
      ),
      itemCount: items.length,
      padding: const EdgeInsets.symmetric(vertical: 28),
      itemBuilder: (BuildContext context, index) => items[index],
    );
  }
}
