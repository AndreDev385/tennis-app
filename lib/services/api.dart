import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/environment.dart';

const apiUrl = Environment.apiUrl;

class Api {
  static Future<http.Response> get(String url) async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    String accessToken = storage.getString("accessToken") ?? "";

    Map<String, String> headers = {
      "Authorization": accessToken,
    };

    final response = await http.get(Uri.parse("$apiUrl$url"), headers: headers);

    return response;
  }

  static Future<http.Response> post(
    String url,
    Map<String, dynamic> data,
  ) async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    String accessToken = storage.getString("accessToken") ?? "";

    Map<String, String> headers = {
      "Authorization": accessToken,
    };

    final response = await http.post(
      Uri.parse("$apiUrl$url"),
      headers: headers,
      body: data,
      encoding: Encoding.getByName('application/json'),
    );

    return response;
  }

  static Future<http.Response> put(
    String url,
    Map<String, dynamic> data,
  ) async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    String accessToken = storage.getString("accessToken") ?? "";

    Map<String, String> headers = {
      "Authorization": accessToken,
    };

    final response = await http.put(
      Uri.parse("$apiUrl$url"),
      headers: headers,
      body: data,
    );

    return response;
  }

  static Future<http.Response> patch(
    String url,
    Map<String, dynamic> data,
  ) async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    String accessToken = storage.getString("accessToken") ?? "";

    Map<String, String> headers = {
      "Authorization": accessToken,
    };

    final response = await http.patch(
      Uri.parse("$apiUrl$url"),
      headers: headers,
      body: data,
    );

    return response;
  }

  static Future<http.Response> delete(String? url) async {
    SharedPreferences storage = await SharedPreferences.getInstance();

    String accessToken = storage.getString("accessToken") ?? "";

    Map<String, String> headers = {
      "Authorization": accessToken,
    };

    final response = await http.get(
      Uri.parse("$apiUrl$url"),
      headers: headers,
    );

    return response;
  }
}
