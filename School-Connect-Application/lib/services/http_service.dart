import 'dart:developer';
import 'dart:io';
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
      log('DioException: ${e.response?.data}');
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception('An unexpected error occurred');
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

  Future<Response> downloadRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      Response response = await dio.download(endpoint, data);
      return response;
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    }
  }

// Function to upload Excel data
  Future<Response> uploadExcelData(
    String endpoint,
    List<Map<String, dynamic>> data,
  ) async {
    // Create a new Dio instance within the function to ensure immutability
    Dio dioInstance = Dio();

    try {
      Response response = await dioInstance.post(
        endpoint,
        data: List<Map<String, dynamic>>.unmodifiable(
            data), // Make data immutable
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      return response;
    } catch (e) {
      log('Error: $e');
      // Return a failed response
      return Response(
          statusCode: 500,
          requestOptions: RequestOptions(path: endpoint),
          statusMessage: 'Error during upload');
    }
  }

// Function to upload an image file
  Future<Response> uploadImageFile(File file, String endpoint) async {
    Dio dioInstance = Dio(); // Create a new Dio instance for this method's use

    try {
      // Prepare form data with the file
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename:
              file.path.split('/').last, // Extract the file name from the path
        ),
      });

      // Post the image file to the specified endpoint
      Response response = await dioInstance.post(
        endpoint,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data'
          }, // Ensure multipart content type
        ),
      );

      // Log success or failure based on the response status
      if (response.statusCode == 200) {
        log('Image uploaded successfully: ${response.data}');
      } else {
        log('Failed to upload image: ${response.statusCode} - ${response.statusMessage}');
      }

      // Return the response in both success and failure cases
      return response;
    } on DioException catch (dioError) {
      // Catch Dio-specific errors, e.g., server issues, connectivity, timeouts
      log('DioError during image upload: ${dioError.response}');
      if (dioError.response?.data != null) {
        log('DioError response data: ${dioError.response?.data}');
      }
      // Return the error response, if available
      return dioError.response ??
          Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: endpoint),
            statusMessage: 'DioError: ${dioError.message}',
          );
    } catch (e) {
      // Catch any other general errors
      log('Unexpected error during image upload: $e');
      // Return a generic error response
      return Response(
        statusCode: 500,
        requestOptions: RequestOptions(path: endpoint),
        statusMessage: 'Error: $e',
      );
    }
  }

  void _initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          log(' ${error.message}');
          if (error.response != null) {
            log('Error status code: ${error.response?.statusCode}');
          }
          handler.next(error);
        },
        onRequest: (request, handler) {
          log("Request ${request.method} ${request.path}");
          handler.next(request);
        },
        onResponse: (response, handler) {
          log('Response data: ${response.data}');
          handler.next(response);
        },
      ),
    );
  }
}
