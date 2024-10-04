import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StyledSearchTextField extends StatefulWidget {
  final String placeholder;

  const StyledSearchTextField({super.key, this.placeholder = ''});

  @override
  State<StyledSearchTextField> createState() => _StyledSearchTextFieldState();
}

class _StyledSearchTextFieldState extends State<StyledSearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        constraints: const BoxConstraints(
          maxHeight: 48,
        ),
        hintStyle: const TextStyle(
          height: 1.2,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: SvgPicture.asset(
            'assets/images/search_lupa.svg',
          ),
        ),
        hintText: widget.placeholder,
      ),
    );
  }
}
