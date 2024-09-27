import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CompositionPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        initialUrl: 'https://jpzysmr9sapp6pkzkords.streamlit.app//',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
