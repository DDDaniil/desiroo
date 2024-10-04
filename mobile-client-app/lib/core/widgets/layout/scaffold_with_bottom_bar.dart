
import 'package:desiroo/core/constants/styled_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomBar extends StatefulWidget {
  const ScaffoldWithBottomBar({
    super.key,
    required this.child,
    required this.state,
  });

  final Widget child;
  final GoRouterState state;

  @override
  State<ScaffoldWithBottomBar> createState() => _ScaffoldWithBottomBarState();
}

class _ScaffoldWithBottomBarState extends State<ScaffoldWithBottomBar> {

  List routes = ['/', '/wishlists'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        surfaceTintColor: StyledConstants.colorBackground,
        height: 64,
        selectedIndex: routes.indexOf(widget.state.matchedLocation),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.card_giftcard),
              selectedIcon: Icon(Icons.card_giftcard_outlined),
              label: 'Wishlists'),
        ],
        onDestinationSelected: (index) {
          GoRouter.of(context).go(routes[index]);
        },
      ),
      body: widget.child,
    );
  }
}
