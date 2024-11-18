import 'package:bao_register/service_implementation/index_service.dart';
import 'package:bao_register/views/index_page_grid_view.dart';
import 'package:flutter/material.dart';

import '../widgets/shortcut_icon.dart';

List<ShortcutIcon> shortcuts = [];

class IndexPage extends StatefulWidget {
  final String uuid;

  const IndexPage({
    super.key,
    required this.uuid,
  });

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final IndexService _indexService = IndexService();

  @override
  void initState() {
    super.initState();
    getShortcutListJson(widget.uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: IndexPageGridView(icons: shortcuts),
      ),
    );
  }

  void getShortcutListJson(String uuid) async {
    List<dynamic> shortcutListJson = await _indexService.getShortcutList(uuid);

    setState(() {
      for (Map<String, dynamic> shortcut in shortcutListJson) {
        shortcuts.add(
          ShortcutIcon(
            type: shortcut['shortcut_type_id'],
            imagePath: shortcut['icon'],
            title: shortcut['shortcut_title'],
          ),
        );
      }
    });
  }
}
