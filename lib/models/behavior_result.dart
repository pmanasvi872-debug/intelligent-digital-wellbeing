class BehaviorResult {
  final int totalScreenTimeMinutes;
  final String mostUsedApp;
  final int appSwitches;
  final int sessionCount;
  final double focusPercentage;
  final String usagePattern;
  final String behaviorType;
  final String riskLevel;
  final int riskScore;

  const BehaviorResult({
    required this.totalScreenTimeMinutes,
    required this.mostUsedApp,
    required this.appSwitches,
    required this.sessionCount,
    required this.focusPercentage,
    required this.usagePattern,
    required this.behaviorType,
    required this.riskLevel,
    required this.riskScore,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalScreenTimeMinutes': totalScreenTimeMinutes,
      'mostUsedApp': mostUsedApp,
      'appSwitches': appSwitches,
      'sessionCount': sessionCount,
      'focusPercentage': focusPercentage,
      'usagePattern': usagePattern,
      'behaviorType': behaviorType,
      'riskLevel': riskLevel,
      'riskScore': riskScore,
    };
  }
}