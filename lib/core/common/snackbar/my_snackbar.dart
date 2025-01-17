import 'package:flutter/material.dart';
mySnackBar({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color ?? Colors.green,
    content: Text(message),
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16), // Adds margin to prevent overlap
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      )
  ));
}
