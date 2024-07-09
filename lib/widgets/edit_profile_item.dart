import 'package:flutter/material.dart';

class EditProfileItem extends StatelessWidget {
  final Widget widget;
  final String title;

  const EditProfileItem({super.key, required this.widget, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Text(
          title,
          style: TextStyle(fontSize: screenWidth * 0.046, color: Colors.grey),
        )),
        SizedBox(width: screenWidth * 0.03),
        Expanded(
          flex: 3,
          child: widget,
        )
        // Exp
      ],
    );
  }
}
