import 'package:flutter/material.dart';

/// A button with a primary style, customizable with various properties.
class PrimaryButton extends StatelessWidget {
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

  /// Creates a [PrimaryButton].
  ///
  /// The [onPressed], [text], and [super.key] parameters are required.
  /// The [buttonColor], [textColor], and [textStyle] parameters are optional.
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.buttonColor,
    this.textColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(
          120.0,
          52.0,
        ),
        elevation: 0.0,
        padding: const EdgeInsets.all(10.0),
        backgroundColor: buttonColor ?? Colors.grey,
        foregroundColor: textColor ?? Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(52.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Text(
          text.toUpperCase(),
          style: textStyle ?? const TextStyle(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
