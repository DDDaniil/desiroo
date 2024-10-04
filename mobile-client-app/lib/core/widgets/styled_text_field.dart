import 'package:desiroo/core/constants/styled_constants.dart';
import 'package:flutter/material.dart';

class StyledTextField extends StatefulWidget {
  final String placeholder;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const StyledTextField({
    super.key,
    this.placeholder = '',
    required this.controller,
    this.validator,
  });

  @override
  State<StyledTextField> createState() => _StyledTextFieldState();

}

class _StyledTextFieldState extends State<StyledTextField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(StyledConstants.borderRadius),
        ),
        hintStyle: const TextStyle(
          fontSize: StyledConstants.fontSizeButton,
          height: StyledConstants.textHeight,
        ),
        hintText: widget.placeholder,
      ),
    );
  }
}
