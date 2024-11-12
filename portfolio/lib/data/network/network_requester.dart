import 'dart:io';
import 'package:dio/dio.dart';
import 'package:my_portfolio_web_app/data/network/network_exception_handler.dart';
import 'package:my_portfolio_web_app/data/network/utils/helper/urls.dart';




class NetworkRequester {
  late Dio _dio;

  NetworkRequester._privateConstructor() {
    prepareRequest();
  }

  static final NetworkRequester shared = NetworkRequester._privateConstructor();

  void prepareRequest() {
    BaseOptions dioOptions = BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      //requestEncoder: null,
      baseUrl: URLs.baseUrl,

      // todo base url
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      // queryParameters: { todo header
      //   'appid': API_KEY,
      // },
      maxRedirects: 2,
      headers: {

        HttpHeaders.userAgentHeader: 'dio',
        'api': '1.0.0',
        'Accept': "*/*",
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        //'x-api-key' : 'xApiKey',
      },
    );

    _dio = Dio(dioOptions);

    _dio.interceptors.clear();

    _dio.interceptors.addAll([
      LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      )
    ]);
  }

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? query,
  }) async {
    try {
      // String accessToken = await storage.getAccessToken();
      final options = Options(
        //headers: {   'Authorization': "Bearer $accessToken",}
      );
      final response = await _dio.get(

        path,
        queryParameters: query,
        options: options
      );
      return response.data;
    } on SocketException catch (_) {
      return NetworkExceptionHandler.handleError(Exception('Network Error'));
    } on Exception catch (exception) {
      return NetworkExceptionHandler.handleError(exception);
    }
  }

  Future<dynamic> post({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
     // String accessToken = await storage.getAccessToken();
      final options = Options(
          //headers: {   'Authorization': "Bearer $accessToken",}
      );
      final response = await _dio.post(
        path,
        queryParameters: query,
        data: data,
          options: options,
      );
      return response.data;
    } on SocketException catch (_) {
      return NetworkExceptionHandler.handleError(Exception('Network Error'));
    } on Exception catch (error) {
      return NetworkExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> put({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.put(path, queryParameters: query, data: data);
      return response.data;
    } on Exception catch (error) {
      return NetworkExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> patch({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response =
          await _dio.patch(path, queryParameters: query, data: data);
      return response.data;
    } on Exception catch (error) {
      return NetworkExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> delete({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: query,
        data: data,
      );
      return response.data;
    } on Exception catch (error) {
      return NetworkExceptionHandler.handleError(error);
    }
  }
}
