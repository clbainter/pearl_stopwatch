import 'package:flutter/material.dart';

/// A circular button widget with customizable properties.
class CircleButton extends StatelessWidget {
  /// A callback function that will be invoked when the button is pressed.
  final VoidCallback onPressed;

  /// The text displayed on the button.
  final String text;

  /// The background color of the button. If not provided, defaults to [Colors.grey].
  final Color? buttonColor;

  /// The text color of the button. If not provided, defaults to [Colors.black].
  final Color? textColor;

  /// The style of the text displayed on the button.
  final TextStyle? textStyle;

  /// Creates a [CircleButton].
  ///
  /// The [onPressed], [text], and [super.key] parameters are required.
  /// The [buttonColor], [textColor], and [textStyle] parameters are optional.
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
