import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './forward_button.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final String? value;
  final IconData icon;
  final Function() onTap;

  const SettingItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      this.value});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: screenWidth,
        child: Row(
          children: [
            CircleAvatar(
              radius: screenWidth * 0.075,
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                color: Colors.black38,
                size: screenWidth * 0.085,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.04,
            ),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: screenWidth * 0.045),
            ),
            const Spacer(),
            value != null
                ? Text(
                    value!,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth * 0.04),
                  )
                : const SizedBox(),
            const SizedBox(
              width: 10,
            ),
            const ForwardButton()
          ],
        ),
      ),
    );
  }
}

class SettingSwitch extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function(bool) onTap;
  final bool value;

  const SettingSwitch(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      required this.value});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final lightTheme = Theme.of(context).brightness == Brightness.light;

    return SizedBox(
      width: screenWidth,
      child: Row(
        children: [
          CircleAvatar(
            radius: screenWidth * 0.075,
            backgroundColor: lightTheme ? Colors.white : Colors.grey[800],
            child: Icon(
              icon,
              color: lightTheme ? Colors.black38 : Colors.white70,
              size: screenWidth * 0.085,
            ),
          ),
          SizedBox(
            width: screenWidth * 0.04,
          ),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: screenWidth * 0.045),
          ),
          const Spacer(),
          CupertinoSwitch(
            value: value,
            onChanged: onTap,
          ),
        ],
      ),
    );
  }
}
