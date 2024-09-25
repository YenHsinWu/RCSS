import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SlidingLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: WebView(
        initialUrl: 'https://bs6fhflzzy5tkuphlvppby.streamlit.app/',
        javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
