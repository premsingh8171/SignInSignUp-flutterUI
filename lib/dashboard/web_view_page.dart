import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../apifunction/tabs/custom_tabs.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (String url) {
          setState(() {
            isLoading = false;
          });
        },
        onWebResourceError: (WebResourceError error) {
          print('Web resource error: $error');
        },
      ),
    )..loadRequest(
        Uri.parse('https://flutter.dev'),
      );
  }

  Future<void> _handleRefresh() async {
    try {
      await controller.reload();
    } catch (e) {
      print('Error reloading WebView: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Flutter WebView', style: TextStyle(
          color: Colors.white
        ),),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white,),
            onPressed: () => controller.reload(),
                   ),

        ],
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _handleRefresh,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // WebView widget to display the web content
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: WebViewWidget(
                      controller: controller,
                    ),
                  ),
                ],
              ),
            ),
          ),
        //  if (isLoading)Center(child: CircularProgressIndicator(),),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}