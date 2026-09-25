import 'package:flutter_test/flutter_test.dart';
import 'package:intelligent_digital_wellbeing/AI/behavior_analyzer.dart';
import 'package:intelligent_digital_wellbeing/AI/insight_generator.dart';

void main() {
  test('BehaviorAnalyzer detects high screen-time usage', () {
    final result = BehaviorAnalyzer.analyze(
      usageStats: [
        {
          'packageName': 'com.instagram.android',
          'appName': 'Instagram',
          'usageTime': 21600000,
        },
        {
          'packageName': 'com.google.android.youtube',
          'appName': 'YouTube',
          'usageTime': 7200000,
        },
      ],
      usageEvents: [
        {
          'packageName': 'com.instagram.android',
          'timestamp': 1000,
          'eventType': 'foreground',
        },
        {
          'packageName': 'com.google.android.youtube',
          'timestamp': 2000,
          'eventType': 'foreground',
        },
        {
          'packageName': 'com.instagram.android',
          'timestamp': 3000,
          'eventType': 'foreground',
        },
      ],
    );

    expect(result.totalScreenTimeMinutes, 480);
    expect(result.mostUsedApp, 'Instagram');
    expect(result.appSwitches, 2);
    expect(result.sessionCount, 3);
    expect(result.riskLevel, 'High');

    print('Screen Time: ${result.totalScreenTimeMinutes} minutes');
    print('Most Used App: ${result.mostUsedApp}');
    print('App Switches: ${result.appSwitches}');
    print('Risk Level: ${result.riskLevel}');
    print('Risk Score: ${result.riskScore}');
    print('Behavior: ${result.behaviorType}');
    print('Pattern: ${result.usagePattern}');
  });

  test('InsightGenerator creates personalized insight', () {
    final result = BehaviorAnalyzer.analyze(
      usageStats: [
        {
          'packageName': 'com.instagram.android',
          'appName': 'Instagram',
          'usageTime': 21600000,
        },
        {
          'packageName': 'com.google.android.youtube',
          'appName': 'YouTube',
          'usageTime': 7200000,
        },
      ],
      usageEvents: [
        {
          'packageName': 'com.instagram.android',
          'timestamp': 1000,
          'eventType': 'foreground',
        },
        {
          'packageName': 'com.google.android.youtube',
          'timestamp': 2000,
          'eventType': 'foreground',
        },
        {
          'packageName': 'com.instagram.android',
          'timestamp': 3000,
          'eventType': 'foreground',
        },
      ],
    );

    final insight = InsightGenerator.generateInsight(result);
    final recommendation =
        InsightGenerator.generateRecommendation(result);

    print('Insight: $insight');
    print('Recommendation: $recommendation');

    expect(insight.isNotEmpty, true);
    expect(recommendation.isNotEmpty, true);
    expect(insight.contains('Instagram'), true);
    expect(recommendation.contains('break'), true);
  });
}