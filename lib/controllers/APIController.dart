import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/Constant.dart';

class APIController extends GetxController {
  // postRequest({
  //   required String route,
  //   required Map<String, String> data,
  // }) async {
  //   String url = apiUrl + route;
  //   await http.post(
  //     Uri.parse(url),
  //     body: jsonEncode(data),
  //     headers: _header(),
  //   );
  // }
  Future<http.Response> postRequest({
    required String route,
    required Map<String, String> data,
  }) async {
    String url = apiUrl + route;
    return await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: _header(),
    );
  }

  _header() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
