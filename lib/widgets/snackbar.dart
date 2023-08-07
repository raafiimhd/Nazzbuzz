import 'package:flutter/material.dart';

SnackBaaaar({
  required String text,
  required BuildContext context,
}) {
  return ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        width: 200,
        duration: const Duration(seconds: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: Colors.purple.shade300,
        content: Center(
          child: Text(text),            
        ),
      ),
    );
}