import 'package:dio/dio.dart';

class ApiErrorInterceptor extends Interceptor
{
  @override
  void onError(DioException err, ErrorInterceptorHandler handler)
  {
    final errorMessage = _extractErrorMessage(err);

    final failureEnvelope =
    {
      'success': false,
      'data': null,
      'error': errorMessage,
    };

    // Resolve as a normal 200 so response.data reaches fromJson() unchanged —
    // callers never need to know a transport-level failure happened.
    handler.resolve(Response(
      requestOptions: err.requestOptions,
      data: failureEnvelope,
      statusCode: 200,
    ));
  }

  String _extractErrorMessage(DioException err)
  {
    // Backend's ApiResponse<T> already puts a human-readable message in "error" —
    // prefer that over dio's generic exception text when it's present.
    final responseData = err.response?.data;

    if (responseData is Map<String, dynamic> && responseData['error'] != null)
    {
      return responseData['error'] as String;
    }

    switch (err.type)
    {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'The request timed out. Please check your connection and try again.';
      case DioExceptionType.connectionError:
        return 'Unable to reach the server. Please check your connection.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}