import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? buttonColor;
  final Color? textColor;
  final TextStyle? textStyle;

  const CircleButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.buttonColor,
    this.textColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: 84.0,
        height: 84.0,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            padding: const EdgeInsets.all(10.0),
            backgroundColor: buttonColor ?? Colors.grey,
            foregroundColor: textColor ?? Colors.black,
            shape: CircleBorder(
              side: BorderSide(
                color: textColor ?? Colors.black,
                width: 2.0,
              ),
            ),
          ),
          child: Text(
            text,
            style: textStyle ?? const TextStyle(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
