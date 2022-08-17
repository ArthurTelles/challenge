// ignore_for_file: avoid_print
import 'dart:io';

import 'package:dio/dio.dart';

class DioRepository {
  Dio _dio = Dio();
  final _baseUrl = 'https://62968cc557b625860610144c.mockapi.io/';

  DioRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
      ),
    );
    initializeInterceptors();
  }

  Future<Response> getRequest(String endPoint) async {
    Response response;
    try {
      response = await _dio.get(endPoint);
    } on DioError catch (error) {
      print(error.message);
      throw Exception(error.message);
    }
    return response;
  }

  Future<Response> postRequest(String endPoint, String? data) async {
    Response response;
    try {
      response = await _dio.post(
        endPoint,
        options: Options(
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        ),
        data: data,
      );
    } on DioError catch (error) {
      print(error.message);
      throw Exception(error.message);
    }
    return response;
  }

  Future<Response> putRequest(String endPoint, String? data) async {
    Response response;
    try {
      response = await _dio.put(
        endPoint,
        options: Options(
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        ),
        data: data,
      );
    } on DioError catch (error) {
      print(error.message);
      throw Exception(error.message);
    }
    return response;
  }

  Future<Response> deleteRequest(String endPoint) async {
    Response response;
    try {
      response = await _dio.delete(
        endPoint,
        options: Options(
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        ),
      );
    } on DioError catch (error) {
      print(error.message);
      throw Exception(error.message);
    }
    return response;
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        print('dio error: ${error.message}');
        handler.next(error);
      },
      onRequest: (request, handler) {
        print('dio request: ${request.method} ${request.path}');
        handler.next(request);
      },
      onResponse: (response, handler) {
        print('dio response: ${response.data}');
        handler.next(response);
      },
    ));
  }
}
