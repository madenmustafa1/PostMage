import 'package:flutter/material.dart';
import '/widgets/text_and_button/simple_text.dart';

class CustomSwitchButton extends StatefulWidget {
  const CustomSwitchButton({
    Key? key,
    required this.text,
    required this.switchCallback,
  }) : super(key: key);

  final Function(bool switchValue) switchCallback;
  final String text;

  @override
  State<CustomSwitchButton> createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton> {
  bool privateShareSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: 15),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 5,
          ),
          child: SimpleText(
            text: widget.text,
            textIsNormal: true,
            optionalTextSize: 22,
          ),
        ),
        Switch(
          value: privateShareSwitched,
          onChanged: (value) {
            setState(
              () {
                privateShareSwitched = value;
                widget.switchCallback(value);
              },
            );
          },
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
