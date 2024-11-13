import 'package:flutter/material.dart';

class ShortcutIcon extends StatelessWidget {
  final int type;
  final String imagePath;
  final String title;

  const ShortcutIcon({
    super.key,
    required this.type,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Image.asset(imagePath),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
