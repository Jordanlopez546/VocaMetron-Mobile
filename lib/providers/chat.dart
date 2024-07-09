import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'package:flutter/widgets.dart';

import '../utils/url.dart';
import '../utils/gemini_service.dart';
import '../utils/return_user_id.dart';
import '../utils/connectivity_helper.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final String messageId;

  ChatMessage(
      {required this.text, required this.isUser, required this.messageId});

  // Add these methods for JSON serialization
  Map<String, dynamic> toJson() => {
        'text': text,
        'isUser': isUser,
        'messageId': messageId,
      };

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        text: json['text'],
        isUser: json['isUser'],
        messageId: json['messageId'],
      );
}

class ChatbotProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];
  bool _isTyping = false;
  String? _userId, _jwtToken;

  List<ChatMessage> get messages => _messages;
  bool get isTyping => _isTyping;
  String? get userId => _userId;

  ChatbotProvider() {
    _messages = [];
  }

  void addUserMessage(String text) async {
    final messageId = const Uuid().v4(); // Generate unique message ID
    _messages.insert(
        0, ChatMessage(text: text, isUser: true, messageId: messageId));
    await saveMessages(text, messageId, true);
    notifyListeners();
  }

  void _setIsTyping(bool val) {
    _isTyping = val;
    notifyListeners();
  }

  Future<void> getAIResponse(String userInput) async {
    _setIsTyping(true);

    try {
      final response = await GeminiService.generateResponse(userInput);
      // Simulate a delay for AI response
      await Future.delayed(const Duration(seconds: 2));
      final messageId = const Uuid().v4(); // Generate unique message ID
      _messages.insert(
          0, ChatMessage(text: response, isUser: false, messageId: messageId));
      await saveMessages(response, messageId, false);
    } catch (e) {
      throw Exception('Failed to load ai responses');
    } finally {
      _setIsTyping(false);
      notifyListeners();
    }
  }

  Future<void> saveMessages(String text, String messageId, bool isUser) async {
    bool isConnected = await ConnectivityHelper.isInternetAvailable();

    if (!isConnected) {
      throw Exception('No internet connection');
    }

    _userId ??= await ReturnUser.getUserData("userId");
    _jwtToken ??= await ReturnUser.getUserData("jwt");

    final url = Uri.parse('$apiUrl/app/messages/user/user-messages');
    final headers = {
      'Authorization': 'Bearer $_jwtToken',
      'x-csrf-token': "csrfToken",
      'Content-Type': 'application/json'
    };

    final body = json.encode({
      'text': text,
      'isUser': isUser,
      'messageId': messageId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        //
      } else {
        throw Exception('Failed to save messages');
      }
    } catch (e) {
      throw Exception('Error when saving messages $e');
    }
  }

  Future<void> loadMessages() async {
    bool isConnected = await ConnectivityHelper.isInternetAvailable();

    if (!isConnected) {
      throw Exception('No internet connection');
    }

    _userId ??= await ReturnUser.getUserData("userId");

    _jwtToken ??= await ReturnUser.getUserData("jwt");

    final url = Uri.parse('$apiUrl/app/messages/user/user-messages');

    final headers = {
      'Authorization': 'Bearer $_jwtToken',
      'x-csrf-token': "csrfToken",
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        _messages =
            decodedData.map((item) => ChatMessage.fromJson(item)).toList();

        _messages = _messages.reversed.toSet().toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load user chats');
      }
    } catch (e) {
      rethrow;
    }
  }

  void clearMessages() {
    _messages.clear();
    _userId = null;
    _jwtToken = null;
    notifyListeners();
  }
}
