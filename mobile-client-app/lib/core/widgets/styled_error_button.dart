import 'package:desiroo/core/constants/styled_constants.dart';
import 'package:flutter/material.dart';

class StyledErrorButton extends StatelessWidget {
  const StyledErrorButton({
    super.key,
    required this.text,
    required this.onPress,
  });

  final String text;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor:  MaterialStateColor.resolveWith((states) => Colors.red),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
      onPressed: onPress,
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: StyledConstants.edgeInsetsHorizontal,
                  vertical: StyledConstants.edgeInsetsVertical
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: StyledConstants.fontSizeButton,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
