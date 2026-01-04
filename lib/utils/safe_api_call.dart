import 'dart:developer';

import 'package:dio/dio.dart';

/// A utility function to safely call an API and handle success and error cases.
///
/// [T] represents the type of the API response.

Future<void> safeApiCall<T>(Future<T> apiRequest, {required void Function(T) onSuccess, required void Function(Object) onError}) async {
  try {
    final result = await apiRequest as dynamic;

    if (result.status.toString().toLowerCase() == "success") {
      onSuccess.call(result);
    } else {
      throw Exception('Something went wrong');
    }
  } on DioException catch (dioError) {
    onError.call(_handleError(dioError));
  } catch (error) {
    onError.call(Exception(error.toString()));
  }
}

Exception _handleError(DioException dioException) {
  log("${dioException.requestOptions.headers.entries} ${dioException.message}");
  switch (dioException.type) {
    case DioExceptionType.connectionTimeout:
      return Exception('Something went wrong');

    case DioExceptionType.sendTimeout:
      return Exception('Something went wrong');
    case DioExceptionType.receiveTimeout:
      return Exception('Something went wrong');
    case DioExceptionType.badCertificate:
      return Exception('Something went wrong');
    case DioExceptionType.badResponse:
      if (dioException.response?.statusCode == 402) {
        dioException.response?.data['creditDeduct'];
      }
      return Exception('Something went wrong');

    case DioExceptionType.cancel:
      return Exception('Something went wrong');
    case DioExceptionType.connectionError:
      return Exception('Something went wrong');
    case DioExceptionType.unknown:
      return Exception('Something went wrong');
  }
}
