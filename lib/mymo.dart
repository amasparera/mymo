library mymo;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart';

part 'api/my_exception.dart';
part 'api/my_api.dart';
part 'handle/my_handle.dart';
part 'helper/my_compare.dart';
part 'controller/my_controller.dart';
part 'controller/my_dependency.dart';
part 'controller/my_stream.dart';
part 'controller/my_lifecycle.dart';
part 'controller/my_view.dart';

class MyMo {
  const MyMo();

  static String _url = '';
  static String get url => _url;

  static Map<String, dynamic> _headers = {};
  static Map<String, dynamic> get headers => _headers;
  static Future<void> install({String? apiUrl, Map<String, dynamic>? apiHeaders}) async {
    _url = url;
    _headers = apiHeaders ?? {};
  }
}
