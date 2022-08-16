// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '/util/app_util.dart';
import '/widgets/text_and_button/simple_text.dart';

class HomePageUserTitle extends StatelessWidget {
  HomePageUserTitle({Key? key}) : super(key: key);

  String nameSurname = "Mustafa Maden";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: AppUtil.getWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: SimpleText(
                  text: "Sn. $nameSurname,",
                  optionalTextSize: AppUtil.getWidth(context) / 15,
                  textIsNormal: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: SimpleText(
                  text: "lorem ipsum.",
                  optionalTextSize: AppUtil.getWidth(context) / 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
