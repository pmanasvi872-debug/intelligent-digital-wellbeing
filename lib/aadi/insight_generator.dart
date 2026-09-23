import '../models/behavior_result.dart';

class InsightGenerator {
  static String generateInsight(BehaviorResult result) {
    final insights = <String>[];

    if (result.totalScreenTimeMinutes >= 360) {
      insights.add(
        'Your screen time is quite high today. '
        'Consider taking short breaks between sessions.',
      );
    } else if (result.totalScreenTimeMinutes >= 180) {
      insights.add(
        'You have spent a significant amount of time on your phone today. '
        'A short digital break may help maintain balance.',
      );
    }

    if (result.appSwitches >= 30) {
      insights.add(
        'You switched between apps frequently today. '
        'Reducing unnecessary app switching may improve your focus.',
      );
    }

    if (result.behaviorType == 'High social/entertainment usage') {
      insights.add(
        '${result.mostUsedApp} was your most-used app today. '
        'Try setting a short limit if you want to reduce entertainment usage.',
      );
    }

    if (result.focusPercentage >= 80 &&
        result.riskLevel == 'Low') {
      insights.add(
        'Your usage pattern looks balanced today. '
        'Keep maintaining this healthy digital routine.',
      );
    }

    if (result.riskLevel == 'High') {
      insights.add(
        'Several usage indicators suggest a higher-risk usage pattern. '
        'Consider taking a longer digital break and reviewing your app habits.',
      );
    }

    if (insights.isEmpty) {
      insights.add(
        'Your digital usage looks relatively balanced today. '
        'Keep monitoring your routine to maintain healthy habits.',
      );
    }

    return insights.join(' ');
  }

  static String generateRecommendation(BehaviorResult result) {
    if (result.riskLevel == 'High') {
      return 'Take a longer break and reduce non-essential screen time.';
    }

    if (result.appSwitches >= 30) {
      return 'Try a focused session with fewer app switches.';
    }

    if (result.totalScreenTimeMinutes >= 180) {
      return 'Take regular short breaks during phone usage.';
    }

    return 'Continue maintaining your current usage pattern.';
  }
}