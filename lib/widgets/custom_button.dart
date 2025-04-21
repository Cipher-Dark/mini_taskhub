import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget? child;
  final String? text;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  const CustomButton({
    super.key,
    this.child,
    this.text,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  }) : assert(
          text != null || child != null,
          'Either text or child must be provided',
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
          foregroundColor: foregroundColor ?? Colors.black87,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1,
            ),
          ),
        ),
        onPressed: onPressed == null
            ? null
            : () async {
                await onPressed?.call();
              },
        child: child ??
            Text(
              text!,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontFamily: 'regular',
              ),
            ),
      ),
    );
  }
}
