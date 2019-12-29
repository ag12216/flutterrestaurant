import 'dart:async';
import 'package:dio/dio.dart';
import 'package:restaurant/http/urls.dart';

class Request {
  final String _url;
  final dynamic _body;

  Request(this._url, this._body);

  Future<Response> post() async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: urlBase,
        responseType: ResponseType.json,
        connectTimeout: 100000,
        receiveTimeout: 100000,
        contentType: 'application/json',
      ),
    );
    Response response = await dio.post(
      urlBase + _url,
      data: _body,
    );
    return response;
  }
}
