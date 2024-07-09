import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
}
