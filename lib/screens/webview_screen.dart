import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatelessWidget {
  final String url;
  final String title;
  WebviewScreen({@required this.title, @required this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 1, color: Colors.grey[200]))),
        child: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
