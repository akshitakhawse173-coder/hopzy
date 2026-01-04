
import 'package:flutter/foundation.dart';

import '../timelines/common_functions.dart';

class LoggerUtil {
  /// Main error logging function (base implementation)
  static void logError({
    required dynamic error,
    StackTrace? stackTrace,
    String? tag,
    Map<String, dynamic>? extraData,
    bool reportToCrashlytics = true,
    bool showToast = false,
  }) {
    final buffer = StringBuffer();

    // Header with timestamp and tag
    buffer.write('[${DateTime.now().toIso8601String()}] ');
    if (tag != null) buffer.write('[$tag] ');

    // Error message formatting
    buffer.write(_formatError(error));

    // Additional debug information
    if (stackTrace != null) buffer.write('\nStackTrace: $stackTrace');
    if (extraData != null && extraData.isNotEmpty) {
      buffer.write('\nExtra Data:');
      extraData.forEach((key, value) => buffer.write('\n  $key: $value'));
    }

    _printFormatted(buffer.toString());

    if (reportToCrashlytics) _reportToCrashlytics(error, stackTrace);
    if (showToast) CommonFunctions.showErrorToast(error.toString());
  }

  /// Network-specific error logger
  static void logNetworkError({
    required String url,
    required int statusCode,
    dynamic response,
    String? method,
    StackTrace? stackTrace,
  }) {
    logError(
      error: 'Network request failed',
      stackTrace: stackTrace,
      tag: 'NETWORK',
      extraData: {
        'url': url,
        'statusCode': statusCode,
        'method': method ?? 'GET',
        'response': _truncateResponse(response),
      },
    );
  }

  /// API-specific error logger
  static void logApiError({
    required String endpoint,
    required dynamic error,
    dynamic request,
    StackTrace? stackTrace,
    bool showToast = false,
  }) {
    logError(
      error: error,
      stackTrace: stackTrace,
      tag: 'API',
      showToast: showToast,
      extraData: {
        'endpoint': endpoint,
        'request': _truncateRequest(request),
      },
    );
  }

  /// With tag and extra data error logger
  static void logExtraDataError({
    required dynamic error,
    required Map<String, dynamic> extraData,
    required String tag,
    StackTrace? stackTrace,
  }) {
    logError(
      error: error,
      stackTrace: stackTrace,
      tag: tag,
      extraData: extraData,
    );
  }

  // --- Private Helpers --- //

  static String _formatError(dynamic error) {
    if (error is String) return error;
    if (error is Error || error is Exception) return error.toString();
    return 'Unknown error type: ${error.runtimeType}';
  }

  static dynamic _truncateResponse(dynamic response) {
    if (response is String && response.length > 500) {
      return '${response.substring(0, 500)}... [truncated]';
    }
    return response;
  }

  static dynamic _truncateRequest(dynamic request) {
    if (request is Map && request.length > 10) {
      final truncatedMap = Map.fromEntries(request.entries.take(10));
      truncatedMap['_truncated'] = true;
      return truncatedMap;
    }
    return request;
  }

  static void _printFormatted(String message) {
    if (kDebugMode) {
      // Color codes for terminal (red for errors)
      debugPrint('\x1B[31m$message\x1B[0m');
    } else {
      debugPrint(message);
    }
  }

  static Future<void> _reportToCrashlytics(
    dynamic error,
    StackTrace? stackTrace,
  ) async {
    try {
      // Uncomment when Crashlytics is configured
      // await FirebaseCrashlytics.instance.recordError(
      //   error,
      //   stackTrace,
      //   printDetails: false,
      // );
    } catch (e) {
      debugPrint('Crashlytics reporting failed: $e');
    }
  }
}

/// 1. Basic error
// try {
//   // Your code
// } catch (e) {
//   LoggerUtil.logError(error: e);
// }

/// 2. With stack trace
// try {
//   // Your code
// } catch (e, st) {
//   LoggerUtil.logError(error: e, stackTrace: st);
// }

/// 3. Payment error
// try {
//   // Payment processing
// } on PaymentException catch (e) {
//   LoggerUtil.logPaymentError(
//     error: e,
//     amount: 29.99,
//     userId: 'user_123',
//   );
// }

/// 4. Network error
// try {
//   // Network call
// } catch (e) {
//   LoggerUtil.logNetworkError(
//     url: 'https://api.example.com',
//     statusCode: 500,
//     response: e.toString(),
//   );
// }

/// 5. API error
// try {
//   // API call
// } catch (e) {
//   LoggerUtil.logApiError(
//     endpoint: '/users',
//     error: e,
//     request: {'id': 123},
//   );
// }
