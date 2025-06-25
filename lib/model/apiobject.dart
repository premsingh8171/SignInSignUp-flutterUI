import 'package:flutter/material.dart';

class ApiObject {
  final String id;
  final String name;
  final Map<String, dynamic>? data;

  ApiObject({
    required this.id,
    required this.name,
    this.data,
  });

  factory ApiObject.fromJson(Map<String, dynamic> json) {
    return ApiObject(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      data: json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
    );
  }
}
