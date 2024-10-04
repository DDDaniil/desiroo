import 'package:flutter/material.dart';

class TabsSelector extends StatefulWidget {
  const TabsSelector({
    super.key,
    required this.onChange,
  });

  final Function(int index) onChange;

  @override
  State<TabsSelector> createState() => _TabsSelectorState();
}

class _TabsSelectorState extends State<TabsSelector> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: TabBar(
        tabAlignment: TabAlignment.fill,
        dividerHeight: 2,
        onTap: widget.onChange,
        tabs: const [
          Tab(text: 'Your Wishlists'),
          Tab(text: 'Friends'),
        ],
      ),
    );
  }
}
