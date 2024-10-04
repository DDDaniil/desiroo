import 'package:desiroo/core/constants/styled_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SidebarLayout extends StatefulWidget {
  final Widget child;

  const SidebarLayout({
    super.key,
    required this.child,
  });

  @override
  State<SidebarLayout> createState() => _SidebarLayoutState();
}

class _SidebarLayoutState extends State<SidebarLayout> {
  bool isSidebarOpen = false;

  @override
  Widget build(BuildContext context) {
    final sidebarColor = Theme.of(context).disabledColor;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: widget.child,
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            top: 0,
            bottom: 18,
            right: isSidebarOpen ? 8 : MediaQuery.of(context).size.width - 40,
            child: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: isSidebarOpen ? 32.0 : 0,
                          color: Colors.black26.withOpacity(0.2),
                          offset: const Offset(0, 2),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                      color: sidebarColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () => GoRouter.of(context).go('/'),
                            child: const Text(
                              'Home',
                              style: StyledConstants.textStyleTabs,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                GoRouter.of(context).go('/wishlists'),
                            child: const Text(
                              'Wishlists',
                              style: StyledConstants.textStyleTabs,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: isSidebarOpen ? 40 : 50,
                    margin:
                        EdgeInsets.only(top: 14, left: isSidebarOpen ? 4 : 0),
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: isSidebarOpen
                          ? BorderRadius.circular(24)
                          : const BorderRadius.only(
                              topRight: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    child: Align(
                      child: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            isSidebarOpen = !isSidebarOpen;
                          });
                        },
                        icon: Icon(
                          isSidebarOpen ? Icons.arrow_back : Icons.menu_rounded,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
