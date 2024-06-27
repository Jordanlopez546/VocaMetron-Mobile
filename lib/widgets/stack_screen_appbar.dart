import 'package:flutter/material.dart';

class StackScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String _title;

  const StackScreenAppbar(this._title, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_title),
      backgroundColor: Colors.white,
      actions: [
        Image.asset('assets/icon.png', width: 60, height: 100),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
