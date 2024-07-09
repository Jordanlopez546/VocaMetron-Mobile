import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/stack_screen_appbar.dart';
import '../providers/chat.dart';
import '../widgets/typing_dots.dart';

class AiChatScreen extends StatelessWidget {
  static const routeName = '/vocametron-ai-chat';

  AiChatScreen({super.key});

  final Color _backgroundColor = const Color.fromRGBO(234, 242, 255, 1.0);
  final Color _colour = const Color.fromRGBO(0, 166, 166, 1.0);

  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(BuildContext context, String text) {
    if (text.isEmpty) return;
    _textController.clear();

    final chatProvider = Provider.of<ChatbotProvider>(context, listen: false);

    chatProvider.addUserMessage(text);
    chatProvider.getAIResponse(text);
  }

  Widget _buildTextComposer(BuildContext context, Color colour) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final isSmallScreen = screenWidth < 600;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 6.0 : 8.0,
        horizontal: isSmallScreen ? 12.0 : 16.0,
      ),
      margin: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 6.0 : 8.0, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmallScreen ? 20.0 : 30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              onSubmitted: (text) => _handleSubmitted(context, text),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                hintText: "Send a message",
                hintStyle: Theme.of(context).textTheme.titleSmall,
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: colour),
            onPressed: () => _handleSubmitted(context, _textController.text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StackScreenAppbar('VocaMetron AI'),
      backgroundColor: _backgroundColor,
      body: Column(
        children: [
          Expanded(child: Consumer<ChatbotProvider>(
            builder: (context, chatProvider, _) {
              return ListView.builder(
                  reverse: true,
                  itemCount: chatProvider.messages.length +
                      (chatProvider.isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == 0 && chatProvider.isTyping) {
                      return TypingIndicator(colour: _colour);
                    } else {
                      final message = chatProvider
                          .messages[chatProvider.isTyping ? index - 1 : index];
                      return ChatMessageWidget(
                        message: message,
                        colour: _colour,
                      );
                    }
                  });
            },
          )),
          _buildTextComposer(context, _colour),
        ],
      ),
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;
  final Color colour;

  const ChatMessageWidget(
      {super.key, required this.message, required this.colour});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            padding: const EdgeInsets.all(5),
            child: CircleAvatar(
              backgroundColor: colour,
              foregroundColor: Colors.white,
              child: Text(message.isUser ? "You" : "AI"),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message.isUser ? "You" : "VocaMetron AI",
                    style: Theme.of(context).textTheme.titleMedium),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(message.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TypingIndicator extends StatelessWidget {
  final Color colour;

  const TypingIndicator({super.key, required this.colour});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: colour,
            foregroundColor: Colors.white,
            child: const Text("AI"),
          ),
          const SizedBox(width: 10),
          const TypingDots(),
        ],
      ),
    );
  }
}
