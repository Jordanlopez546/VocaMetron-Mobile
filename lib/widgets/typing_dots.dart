import 'package:flutter/material.dart';

class TypingDots extends StatefulWidget {
  const TypingDots({super.key});

  @override
  TypingDotsState createState() => TypingDotsState();
}

class TypingDotsState extends State<TypingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Row(
          children: List.generate(3, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Opacity(
                opacity: _controller.value > index / 3.0 ? 1.0 : 0.2,
                child: const CircleAvatar(
                    radius: 4.0, backgroundColor: Colors.grey),
              ),
            );
          }),
        );
      },
    );
  }
}
