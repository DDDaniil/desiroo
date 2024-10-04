import 'package:desiroo/core/constants/styled_constants.dart';
import 'package:flutter/material.dart';

class StyledWithoutBorderButton extends StatelessWidget {
  const StyledWithoutBorderButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: StyledConstants.edgeInsetsHorizontal,
            vertical: StyledConstants.edgeInsetsVertical
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: StyledConstants.fontSizeButton,
            color: StyledConstants.colorPrimary,
          ),
        ),
      ),
    );
  }
}
