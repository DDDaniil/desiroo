import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text("Desiroo"),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Center(
              child: Text('''Desiroo is the perfect place for anyone who wants to make unforgettable gifts to their loved ones. Thanks to our user-friendly interface and useful features, you can easily find and share lists of desired gifts, as well as make the gift-giving process more enjoyable and exciting.''',
              softWrap: true,),
            ),
          ),
        ),
      ],
    );
  }
}
