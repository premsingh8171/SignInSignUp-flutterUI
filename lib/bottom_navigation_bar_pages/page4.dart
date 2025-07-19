import 'package:flutter/material.dart';

import '../dashboard/documents_upload.dart';

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UploadFileScreen(),
    );
  }
}