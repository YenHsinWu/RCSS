import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SlidingLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        initialUrl: 'https://f8i9s3anaczbqvkfnjxyvx.streamlit.app/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
