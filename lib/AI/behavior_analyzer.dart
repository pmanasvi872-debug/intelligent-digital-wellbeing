import '../models/behavior_result.dart';

class BehaviorAnalyzer {
  static BehaviorResult analyze({
    required List<dynamic> usageStats,
    required List<dynamic> usageEvents,
  }) {
    int totalUsageMs = 0;
    String mostUsedApp = 'Unknown';
    int highestUsageMs = 0;

    final Map<String, int> appUsage = {};

    // Analyze app usage statistics
    for (final item in usageStats) {
      if (item is! Map) continue;

      final appName =
          (item['appName'] ?? item['packageName'] ?? 'Unknown').toString();

      final usageTime =
          int.tryParse(item['usageTime']?.toString() ?? '0') ?? 0;

      totalUsageMs += usageTime;
      appUsage[appName] = usageTime;

      if (usageTime > highestUsageMs) {
        highestUsageMs = usageTime;
        mostUsedApp = appName;
      }
    }

    final totalScreenTimeMinutes =
        (totalUsageMs / 60000).round();

    // Analyze foreground events.
    int appSwitches = 0;
    int sessionCount = 0;

  
    String? lastForegroundPackage;

    for (final item in usageEvents) {
      if (item is! Map) continue;

      final packageName =
          item['packageName']?.toString();

      final eventType =
          item['eventType']?.toString();

      if (packageName == null) continue;

      if (eventType == 'foreground') {
        sessionCount++;

        if (lastForegroundPackage != null &&
            lastForegroundPackage != packageName) {
          appSwitches++;
        }

        lastForegroundPackage = packageName;
      }

    
    }

    // Estimate focus percentage.
    //
    // For the first rule-based version, frequent switching
    // is treated as a distraction indicator.
    final double focusPercentage = appSwitches == 0
        ? 100.0
        : (100 - (appSwitches * 2.0)).clamp(0.0, 100.0);

    // Determine usage pattern.
    String usagePattern;

    if (appSwitches >= 30) {
      usagePattern = 'Frequent app switching';
    } else if (totalScreenTimeMinutes >= 360) {
      usagePattern = 'Heavy screen-time usage';
    } else if (totalScreenTimeMinutes >= 180) {
      usagePattern = 'Moderate screen-time usage';
    } else {
      usagePattern = 'Balanced usage pattern';
    }

    // Determine behavior type.
    String behaviorType;

    final mostUsedLower = mostUsedApp.toLowerCase();

    if (mostUsedLower.contains('instagram') ||
        mostUsedLower.contains('facebook') ||
        mostUsedLower.contains('youtube') ||
        mostUsedLower.contains('tiktok') ||
        mostUsedLower.contains('snapchat')) {
      behaviorType = 'High social/entertainment usage';
    } else if (appSwitches >= 30) {
      behaviorType = 'Distracted usage';
    } else if (focusPercentage >= 80) {
      behaviorType = 'Focused usage';
    } else {
      behaviorType = 'Normal usage';
    }

    // Calculate risk score.
    int riskScore = 0;

    if (totalScreenTimeMinutes >= 360) {
      riskScore += 40;
    } else if (totalScreenTimeMinutes >= 180) {
      riskScore += 20;
    }

    if (appSwitches >= 50) {
      riskScore += 30;
    } else if (appSwitches >= 30) {
      riskScore += 20;
    } else if (appSwitches >= 15) {
      riskScore += 10;
    }

    if (behaviorType == 'High social/entertainment usage') {
      riskScore += 20;
    }

    if (focusPercentage < 50) {
      riskScore += 10;
    }

    riskScore = riskScore.clamp(0, 100);

    String riskLevel;

    if (riskScore >= 60) {
      riskLevel = 'High';
    } else if (riskScore >= 30) {
      riskLevel = 'Medium';
    } else {
      riskLevel = 'Low';
    }

    return BehaviorResult(
      totalScreenTimeMinutes: totalScreenTimeMinutes,
      mostUsedApp: mostUsedApp,
      appSwitches: appSwitches,
      sessionCount: sessionCount,
      focusPercentage: double.parse(
        focusPercentage.toStringAsFixed(1),
      ),
      usagePattern: usagePattern,
      behaviorType: behaviorType,
      riskLevel: riskLevel,
      riskScore: riskScore,
    );
  }
}