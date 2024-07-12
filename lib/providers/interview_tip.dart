import 'package:flutter/widgets.dart';

import '../utils/gemini_service.dart';

class InterviewTip {
  final String title;
  final String description;

  InterviewTip({required this.title, required this.description});

  factory InterviewTip.fromJson(Map<String, dynamic> json) {
    return InterviewTip(
      title: json['title'],
      description: json['description'],
    );
  }
}

class InterviewTipsProvider with ChangeNotifier {
  final List<InterviewTip> _tips = [];

  List<InterviewTip> get tips => _tips;

  void clearTips() {
    _tips.clear();
    notifyListeners();
  }

  Future<void> generateInterviewTips(
      String skills, String experiences, String careerInterests) async {
    try {
      final response = await GeminiService.generateInterviewTips(
          skills, experiences, careerInterests);

      // Clear the existing tips before adding new ones
      _tips.clear();
      _tips.addAll(response);

      // Notify listeners after updating the tips
      notifyListeners();
    } catch (e) {
      debugPrint('Error generating interview tips: $e');
      throw Exception('Failed to generate interview tips');
    }
  }
}
