part of '../mymo.dart';

enum MyApiMethod { get, post, delete, patch, put }

enum MyApiType { dev, beta, prod }

abstract class MyBaseApi {
  Future<MyHandle<Response, MyBaseException>> call({
    required MyApiMethod method,
    required String path,
    String? url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
  });

  Future<StreamedResponse> stream({
    Map<String, String>? body,
    Map<String, String>? headers,
    required File file,
    required String url,
    String? fieldFile,
  });
}

class MyApi extends MyBaseApi {
  ///
  static final Client _http = Client();

  /// melakukan konversi dari map ke string pada url
  String generateUrlEncodedBody({required Map<String, dynamic> body}) {
    return body.isNotEmpty ? body.keys.map((key) => "?$key=${body[key]}").join("&") : '';
  }

  ///
  @override
  Future<MyHandle<Response, MyBaseException>> call({
    required MyApiMethod method,
    required String path,
    String? url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? body,
  }) async {
    try {
      final Uri uri = Uri.https(url ?? MyMo.url, path, params);

      final Map<String, String> headers = {};

      Response respone = switch (method) {
        MyApiMethod.get => await _http.get(uri, headers: headers),
        MyApiMethod.post => await _http.post(uri, body: body, headers: headers),
        MyApiMethod.delete => await _http.delete(uri, body: body, headers: headers),
        MyApiMethod.patch => await _http.patch(uri, body: body, headers: headers),
        MyApiMethod.put => await _http.put(uri, body: body, headers: headers),
      };
      if (respone.statusCode >= 300) {
        return MyHandle.right(MyServerException.fromHttpResponse(respone.statusCode, respone.body));
      }

      return MyHandle.left(respone);
    } catch (error) {
      return MyHandle.right(MyServerException.fromError(error));
    }
  }

  ///
  @override
  Future<StreamedResponse> stream({Map<String, String>? body, Map<String, String>? headers, required File file, required String url, String? fieldFile}) async {
    var request = MultipartRequest('POST', Uri.https('', url));

    request.files.add(await MultipartFile.fromPath(fieldFile ?? 'image', file.path));
    if (headers != null) request.headers.addAll(headers);
    request.headers.addAll({"Content-type": "multipart/form-data"});
    if (body != null) request.fields.addAll(body);
    return await request.send();
  }
}
