import 'package:flutter/foundation.dart';

class Logger {
  /// ## log()
  /// This function would be used to added any other logging capabilities,
  /// e.g. caching logs locally or making a network call, etc.
  static log(String log, {String? tag}) {
    if (kDebugMode) {
      print('${tag ?? ''}${tag != null ? ' :: ' : ''}$log');
    }
  }
}