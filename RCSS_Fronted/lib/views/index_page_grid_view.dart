import 'package:bao_register/widgets/shortcut_icon.dart';
import 'package:flutter/material.dart';

class IndexPageGridView extends StatelessWidget {
  final List<ShortcutIcon> icons;
  const IndexPageGridView({
    super.key,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
      ),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        return icons[index];
      },
    );
  }
}
