import 'package:flutter/material.dart';

class RowNameImage extends StatelessWidget {
  const RowNameImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: ClipOval(
            child: Image.asset(
              'assets/images/blank-profile-picture.png',
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(text: 'Hello '),
                    TextSpan(
                        text: 'Jordan,',
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ]),
            ),
            const Text(
              'Welcome',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        )
      ],
    );
  }
}
