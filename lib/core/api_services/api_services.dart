import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static ApiService? _instance;
  final String baseUrl;

  ApiService._internal(this.baseUrl);

  factory ApiService(String baseUrl) {
    _instance ??= ApiService._internal(baseUrl);

    return _instance!;
  }

  static Future<dynamic> get(String endpoint,
      {Map<String, String>? headers}) async {
    if (_instance == null) {
      throw Exception(
          'ApiService is not initialized. Please call ApiService.initialize() first.');
    }
    final uri = Uri.parse('${_instance!.baseUrl}/$endpoint');

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to load data from $endpoint: ${response.statusCode}\nBody: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during GET request to $endpoint: $e');
    }
  }
}
