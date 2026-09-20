import 'package:flutter/services.dart';

class UsageService {
  static const MethodChannel _channel =
      MethodChannel('digital_wellbeing/usage');

  static Future<List<dynamic>> getUsageStats() async {
    try {
      final result =
          await _channel.invokeMethod('getUsageStats');

      return result ?? [];
    } on PlatformException catch (e) {
      print(
        'Failed to get usage stats: ${e.message}',
      );

      return [];
    }
  }

  static Future<List<dynamic>> getUsageEvents() async {
    try {
      final result =
          await _channel.invokeMethod('getUsageEvents');

      return result ?? [];
    } on PlatformException catch (e) {
      print(
        'Failed to get usage events: ${e.message}',
      );

      return [];
    }
  }
}