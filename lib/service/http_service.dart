import 'dart:convert';

import 'package:http/http.dart';
import '../model/post_model.dart';

class HttpService {
  static bool isTester = false;
  static String SERVER_DEV = "jsonplaceholder.typicode.com";
  static String SERVER_PROD = "jsonplaceholder.typicode.com";

  static String getServer() {
    if (isTester) return SERVER_DEV;
    return SERVER_PROD;
  }

  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  /* Http Requests */

  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(getServer(), api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, dynamic> body) async {
    var uri = Uri.https(getServer(), api);
    var response = await post(uri, body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, dynamic> body) async {
    var uri = Uri.https(getServer(), api);
    var response = await put(uri, body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DEL(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(getServer(), api, params);
    var response = await delete(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  /* Http Apis*/
  static String API_POST_LIST = "/posts";
  static String API_POST_CREATE = "/posts";
  static String API_POST_UPDATE = "/posts/"; //{id}
  static String API_POST_DELETE = "/posts/"; //{id}

  /* Http Params */
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, dynamic> paramsCreatePost(Post post) {
    Map<String, dynamic> params = {};
    params.addAll({
      "title": post.title!,
      "body": post.body!,
      "userId": post.userId!,
    });
    return params;
  }

  static Map<String, dynamic> paramsUpdatePost(Post post) {
    Map<String, dynamic> params = {};
    params.addAll({
      "ID": post.id!,
      "title": post.title!,
      "body": post.body!,
      "userId": post.userId!,
    });
    return params;
  }
}