import 'package:flutter/widgets.dart';

import '../utils/gemini_service.dart';

class CareerItem {
  final String title, outlook, salary, description;
  final List<String> skills, technologies;

  CareerItem({
    required this.title,
    required this.skills,
    required this.technologies,
    required this.outlook,
    required this.salary,
    required this.description,
  });

  factory CareerItem.fromJson(Map<String, dynamic> json) {
    return CareerItem(
      title: json['title'],
      skills: List<String>.from(json['skills']),
      technologies: List<String>.from(json['technologies']),
      outlook: json['outlook'],
      salary: json['salary'],
      description: json['description'],
    );
  }
}

class Career with ChangeNotifier {
  final List<CareerItem> _careers = [];

  List<CareerItem> get careers => _careers;

  void clearCareers() {
    _careers.clear();
    notifyListeners();
  }

  Future<void> generateUserCareers(
      String skills, String experiences, String careerInterests) async {
    try {
      final response = await GeminiService.generateUserCareers(
          skills, experiences, careerInterests);

      // Clear the existing careers before adding new ones
      _careers.clear();
      _careers.addAll(response);

      // Notify listeners after updating the careers
      notifyListeners();
    } catch (e) {
      debugPrint('Error generating career paths: $e');
      throw Exception('Failed to generate career paths: $e');
    }
  }
}
