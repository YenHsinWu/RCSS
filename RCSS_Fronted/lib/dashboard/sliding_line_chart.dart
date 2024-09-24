import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SlidingLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        initialUrl: 'http://10.10.10.204:8501',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}