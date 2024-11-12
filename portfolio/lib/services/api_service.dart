import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio();

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to make GET request: $e');
    }
  }

  Future<Map<String, dynamic>> post(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to make POST request: $e');
    }
  }

  Future<Map<String, dynamic>> put(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to make PUT request: $e');
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to make DELETE request: $e');
    }
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}
