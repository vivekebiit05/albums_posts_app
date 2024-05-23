import 'dart:async';
import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class HttpService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/';
  static final logger = Logger();

  static Future<http.Response> _makeRequest(
    String method,
    String endpoint,
    dynamic data,
  ) async {
    EasyLoading.show(status: 'Please wait...');

    try {
      final Uri uri = Uri.parse('$_baseUrl/$endpoint');
      final headers = {'Content-Type': 'application/json'};
      final body = data != null ? json.encode(data) : null;

      if (!const bool.fromEnvironment('dart.vm.product')) {
        logger.d('Request URL: $_baseUrl/$endpoint');
        if (body != null) logger.d('Request Body: $body');
      }

      final response = method == 'POST'
          ? await http
              .post(uri, body: body, headers: headers)
              .timeout(const Duration(minutes: 1))
          : await http.get(uri, headers: headers);

      if (!const bool.fromEnvironment('dart.vm.product')) {
        logger.d('Response: ${response.body}');
      }

      EasyLoading.dismiss();
      return response;
    } on TimeoutException {
      EasyLoading.dismiss();
      throw Exception('Connection timeout. Please try again later.');
    } on http.ClientException catch (e) {
      EasyLoading.dismiss();
      throw Exception('Failed to connect to the server: $e');
    } catch (e) {
      EasyLoading.dismiss();
      throw Exception('An error occurred: $e');
    }
  }

  static Future<http.Response> postRequest(
      String endpoint, dynamic data) async {
    return _makeRequest('POST', endpoint, data);
  }

  static Future<http.Response> getRequest(String endpoint) async {
    return _makeRequest('GET', endpoint, null);
  }
}
