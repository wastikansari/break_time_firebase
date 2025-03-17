class OnboardingModel {
  final List<String> skills;
  final bool hasSmartphone;
  final bool usedGoogleMaps;
  final String dob;

  OnboardingModel({
    required this.skills,
    required this.hasSmartphone,
    required this.usedGoogleMaps,
    required this.dob,
  });

  Map<String, dynamic> toMap() {
    return {
      'skills': skills,
      'hasSmartphone': hasSmartphone,
      'usedGoogleMaps': usedGoogleMaps,
      'dob': dob,
    };
  }
}