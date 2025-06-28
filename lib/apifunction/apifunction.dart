import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/apiobject.dart';



Future<List<ApiObject>> fetchApiObjects() async {
  final response = await http.get(Uri.parse('https://api.restful-api.dev/objects'));

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => ApiObject.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load objects');
  }
}


