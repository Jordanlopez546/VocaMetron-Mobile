import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';

Future<Response> handleApiRequest(Future<Response> Function() apiCall) async {
  try {
    final response = await apiCall().timeout(const Duration(seconds: 10));
    return response;
  } on SocketException {
    throw 'Unable to connect to the server. Please check your internet connection and try again.';
  } on TimeoutException {
    throw 'The server is taking too long to respond. Please try again later or contact support if the problem persists.';
  } catch (e) {
    throw 'Something went wrong. Please try again later or contact support if the problem continues.';
  }
}
