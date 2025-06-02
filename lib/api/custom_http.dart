// lib/customhttp.dart

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomHttp {
  static final String _baseUrl = dotenv.env['PRODUCTION_SERVER_URL'] ?? '';

  // Example: GET request
  static Future<http.Response> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    return await http.get(url, headers: headers);
  }

  // Example: POST request
  static Future<http.Response> post(String endpoint, {Map<String, String>? headers, Object? body}) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    return await http.post(url, headers: headers, body: body);
  }

  // You can add more methods (PUT, DELETE) as needed
}
