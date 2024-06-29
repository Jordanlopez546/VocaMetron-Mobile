import 'package:flutter/material.dart';

class SlideNotification extends StatefulWidget {
  final String message;

  const SlideNotification(this.message, {super.key});

  @override
  State<SlideNotification> createState() => _SlideNotificationState();
}

class _SlideNotificationState extends State<SlideNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  // Usage

  // void _showNotification(BuildContext context, String message) {
  //   final overlay = Overlay.of(context);
  //   final overlayEntry = OverlayEntry(
  //     builder: (context) => Positioned(
  //       top: 0,
  //       left: 0,
  //       right: 0,
  //       child: SlideNotification(message),
  //     ),
  //   );

  //   overlay.insert(overlayEntry);

  //   Future.delayed(const Duration(seconds: 3), () {
  //     overlayEntry.remove();
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0.45),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: GestureDetector(
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.95, // 95% of screen width
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(
                    234, 242, 255, 1.0), // Background color
                borderRadius: BorderRadius.circular(12), // Border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Text(
                  widget.message,
                  style: const TextStyle(
                      color: Color.fromRGBO(0, 166, 166, 1.0), fontSize: 17),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
