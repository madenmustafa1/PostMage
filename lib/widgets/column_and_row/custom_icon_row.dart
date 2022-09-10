import 'package:flutter/material.dart';

import '../text_and_button/simple_text.dart';

class CustomIconRow extends StatelessWidget {
  const CustomIconRow({
    Key? key,
    required this.title,
    required this.icon,
    required this.callback
  }) : super(key: key);

  final String title;
  final Icon icon;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 10,
          ),
          SimpleText(
            text: title,
            optionalTextSize: 27,
          ),
        ],
      ),
    );
  }
}
