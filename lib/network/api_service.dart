import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lean_scale_food_app/main.dart';
import 'package:lean_scale_food_app/widgets/custom_dialog.dart';

class ApiService {
  Future<String> get(String baseUrl, String path,
      {Map<String, dynamic>? parameters}) async {
    try {
      final response = await http.get(
        Uri.https(baseUrl, path, parameters),
      );
      var responseJson = _response(response);
      return responseJson;
    } catch (error) {
      rethrow;
    }
  }

  Future<String> post(
    String baseUrl,
    String path, {
    Map<String, dynamic>? parameters,
    String? body,
  }) async {
    try {
      final response =
          await http.post(Uri.https(baseUrl, path, parameters), body: body);
      var responseJson = _response(response);
      return responseJson;
    } catch (error) {
      rethrow;
    }
  }

  Future<String> put(
    String baseUrl,
    String path, {
    Map<String, dynamic>? parameters,
    String? body,
  }) async {
    try {
      final response =
          await http.put(Uri.https(baseUrl, path, parameters), body: body);
      var responseJson = _response(response);
      return responseJson;
    } catch (error) {
      rethrow;
    }
  }

  Future<String> delete(String baseUrl, String path,
      {Map<String, dynamic>? parameters}) async {
    try {
      final response = await http.delete(
        Uri.https(baseUrl, path, parameters),
      );
      var responseJson = _response(response);
      return responseJson;
    } catch (error) {
      rethrow;
    }
  }

  String _response(http.Response response) {
    if (response.statusCode != 200) {
      showMyDialog();
      return '';
    } else {
      return response.body;
    }
  }
}

void showMyDialog() {
  showDialog(
      context: navigatorKey.currentContext!,
      builder: (ctx) => const CustomDialog(
            message: "Network Error!",
          ));
}
