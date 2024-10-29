import 'dart:developer';
import 'package:dio/dio.dart';
// import 'package:image_picker/image_picker.dart';

class HttpService {
  final Dio dio;
  final String baseUrl;

  HttpService({this.baseUrl = "http://10.0.2.2:5293/api/"})
      : dio = Dio(BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            headers: {'Content-Type': 'application/json'})) {
    _initializeInterceptors();
  }

  Future<Response> getRequest(String endpoint) async {
    try {
      final response = await dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      log('DioException: ${e.response?.data}');
      throw Exception(e.response?.data);
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<Response> putRequest(String endpoint, dynamic data) async {
    try {
      log("Updatung data on $endpoint...");

      // Log the type of data being posted
      log("Data type: ${data.runtimeType}");

      Response response;

      if (data is FormData) {
        log("Updating multipart form-data...");
        response = await dio.put(endpoint, data: data);
      } else {
        log("Updating regular form-data...");
        response = await dio.put(endpoint, data: data);
      }

      // Log the entire response for debugging purposes
      log('Response received: ${response.data}');

      return response; // Return the full Response object, not just response.data
    } on DioException catch (e) {
      log("${e.response?.data}");
      throw Exception("${e.response?.data}");
    }
  }

  Future<Response> postRequest(String endpoint, dynamic data) async {
    try {
      log("Posting data to $endpoint...");

      // Log the type of data being posted
      log("Data type: ${data.runtimeType}");

      Response response;

      // Check if data is already FormData, otherwise send it as JSON
      if (data is FormData) {
        log("Sending multipart form-data...");
        response = await dio.post(endpoint, data: data);
      } else {
        log("Sending regular form-data...");
        response = await dio.post(endpoint, data: data);
      }

      log("Response received: ${response.data}");
      return response; // Return the full response object
    } on DioException catch (e) {
      log("${e.response?.data}");
      throw Exception("${e.response?.data}");
    }
  }

  Future<Response> deleteRequest(String endpoint) async {
    try {
      log("Deleting data at $endpoint...");

      Response response = await dio.delete(endpoint);

      // Log the entire response for debugging purposes
      log('Response received: ${response.data}');

      return response; // Return the full Response object, not just response.data
    } on DioException catch (e) {
      log("${e.response?.data}");
      throw Exception("${e.response?.data}");
    }
  }

  Future<Response> downloadRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      Response response = await dio.download(endpoint, data);
      return response;
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    }
  }

  void _initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Log request data for debugging
          log("Request to ${options.uri}");
          log("Headers: ${options.headers}");
          log("Data: ${options.data}"); // Logs sensitive data; handle carefully
          handler.next(options);
        },
        onResponse: (response, handler) {
          // Log response data
          log("Response from ${response.requestOptions.uri}");
          log("Status code: ${response.statusCode}");
          log("Response data: ${response.data}"); // Logs sensitive data; handle carefully
          handler.next(response);
        },
        onError: (DioException error, handler) {
          // Log errors
          log("Error: ${error.message}");
          if (error.response != null) {
            log("Error status code: ${error.response?.statusCode}");
            log("Error response data: ${error.response?.data}");
          }
          handler.next(error);
        },
      ),
    );
  }
}
