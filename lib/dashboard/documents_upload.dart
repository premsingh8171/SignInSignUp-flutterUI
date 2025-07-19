import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:untitled1/dashboard/web_view_page.dart';
import 'package:video_player/video_player.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadFileScreen extends StatefulWidget {
  @override
  _UploadFileScreenState createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  File? selectedFile;
  String? fileType;
  VideoPlayerController? _videoController;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'mp4'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final ext = file.path.split('.').last;

      if (ext == 'mp4') {
        _videoController?.dispose();
        _videoController = VideoPlayerController.file(file);
        await _videoController!.initialize();
        await _videoController!.pause();
      }

      setState(() {
        selectedFile = file;
        fileType = ext;
      });
    }
  }

  Future<void> uploadFile() async {
    if (selectedFile == null) return;

    final uri = Uri.parse('https://yourapi.com/upload'); // Replace with your endpoint
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', selectedFile!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      print('✅ Upload successful');
    } else {
      print('❌ Upload failed: ${response.statusCode}');
    }
  }

  Widget previewWidget() {
    if (selectedFile == null) return Text('No file selected');

    if (fileType == 'pdf') {
      return SizedBox(
        child: PDFView(filePath: selectedFile!.path),
      );
    } else if (fileType == 'mp4' && _videoController != null) {
      return AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio,
        child: VideoPlayer(_videoController!),
      );
    }

    return Text('Unsupported file type');
  }

  void navigator() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewPage()),
    );
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
return Scaffold(
      appBar: AppBar(title: Text('Upload PDF or Video')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickFile,
              child: Text('Pick File'),
            ),
            const SizedBox(height: 20),
             Container(
                width: 200,
                height: 200,
                child: previewWidget(),
              ),
            ElevatedButton(
              onPressed: uploadFile,
              child: Text('Upload'),
            ),

            ElevatedButton(
              onPressed: navigator,
              child: Text('WebView'),
            ),
          ],
        ),
      ),
    );  }
}
