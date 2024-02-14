import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewMap extends StatefulWidget {
  @override
  _WebViewMapState createState() => _WebViewMapState();
}

class _WebViewMapState extends State<WebViewMap> {
  late WebViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://inglo-3dmap.vercel.app/',
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (url) {
        // 입력 기능을 유지하기 위한 자바스크립트 주입
        final script = '''
          var inputs = document.querySelectorAll("input");
          inputs.forEach(function(input) {
            input.disabled = false;
          });
        ''';
        // WebView에 자바스크립트 주입
        _controller!.evaluateJavascript(script);
      },
    );
  }
}