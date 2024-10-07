library mymo;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;


part 'api/my_exception.dart';
part 'api/my_api.dart';
part 'handle/my_handle.dart';
part 'helper/my_compare.dart';
part 'pagination/my_refresh.dart';
part 'pagination/my_slivers_refresh.dart';
part 'pagination/my_indicator.dart';
part 'pagination/my_refresh_physics.dart';
part 'pagination/my_footer.dart';
part 'pagination/my_footer_title.dart';


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
