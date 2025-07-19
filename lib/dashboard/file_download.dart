import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

class FileDownloader extends StatefulWidget {
  @override
  _FileDownloaderState createState() => _FileDownloaderState();
}

class _FileDownloaderState extends State<FileDownloader> {
  bool downloading = false;
  String progress = "";

  Future<void> downloadFile(String url, String filename) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission denied')),
      );
      return;
    }

    setState(() {
      downloading = true;
      progress = "Starting download...";
    });

    try {
      final dir = await getApplicationDocumentsDirectory();
      final savePath = "${dir.path}/$filename";

      await Dio().download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              progress = "Downloading: ${(received / total * 100).toStringAsFixed(0)}%";
            });
          }
        },
      );

      setState(() {
        downloading = false;
        progress = "Download complete!";
      });

      OpenFile.open(savePath);
    } catch (e) {
      setState(() {
        downloading = false;
        progress = "Download failed: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final testUrl = 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf'; // Replace with your file URL
    final fileName = 'sample.pdf'; // Change based on file type

    return Scaffold(
      appBar: AppBar(title: Text('Download File')),
      body: Center(
        child: downloading
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(progress),
          ],
        )
            : ElevatedButton(
          onPressed: () => downloadFile(testUrl, fileName),
          child: Text('Download PDF'),
        ),
      ),
    );
  }
}
