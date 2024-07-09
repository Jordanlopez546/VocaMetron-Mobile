import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../providers/interview_tip.dart';

class GeminiService {
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

  static Future<String> generateResponse(String prompt) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    final url = Uri.parse('$_baseUrl?key=$apiKey');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': prompt}
            ]
          }
        ],
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('Failed to generate response');
    }
  }

  // Method to generate interview tips
  static Future<List<InterviewTip>> generateInterviewTips(
      String skills, String experiences, String careerInterests) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    final url = Uri.parse('$_baseUrl?key=$apiKey');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {
                'text':
                    'Generate 40 interview tips in JSON format, each with "title" and "description" fields, based on skills: $skills, experiences: $experiences, and career interests: $careerInterests'
              }
            ]
          }
        ],
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final String content =
          jsonResponse['candidates'][0]['content']['parts'][0]['text'];

      // Extract the JSON part from the content
      final jsonStart = content.indexOf('[');
      final jsonEnd = content.lastIndexOf(']') + 1;
      final jsonString = content.substring(jsonStart, jsonEnd);

      // Parse the JSON string
      final List<dynamic> tipsJson = jsonDecode(jsonString);

      // Convert JSON to InterviewTip objects
      List<InterviewTip> tips =
          tipsJson.map((tipJson) => InterviewTip.fromJson(tipJson)).toList();

      return tips;
    } else {
      throw Exception('Failed to generate interview tips');
    }
  }
}
