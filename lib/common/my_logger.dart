import 'package:logger/logger.dart';

mixin MyLogger {
  static late Logger _logger;

  static void init() {
    _logger = Logger();
  }

  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }
}
