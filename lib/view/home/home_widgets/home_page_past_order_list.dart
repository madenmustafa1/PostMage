import 'package:flutter/material.dart';
import '/util/color_util.dart';
import '/widgets/calc_sized_box.dart';
import '/dependency_injection/setup.dart';
import '/util/constants.dart';
import '/util/app_util.dart';

import '/widgets/text_and_button/simple_text.dart';

class HomePagePastOrderList extends StatelessWidget {
  HomePagePastOrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _horizontalListView(context);
  }

  final Constants constants = getIt<Constants>();

  Widget _horizontalListView(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: AppUtil.getWidth(context) / 15),
              child: SimpleText(
                text: constants.pastOrder,
                textIsNormal: true,
                optionalTextSize: AppUtil.getWidth(context) / 20,
              ),
            ),
          ],
        ),
        const CalcSizedBox(calc: 90),
        SizedBox(
          height: AppUtil.getHeight(context) / 5.5,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, __) => listViewItem(context),
          ),
        ),
      ],
    );
  }

  Widget listViewItem(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppUtil.getWidth(context) / 20,
        right: AppUtil.getWidth(context) / 55,
      ),
      child: Container(
        constraints: BoxConstraints(
          minWidth: AppUtil.getWidth(context) / 2,
          maxWidth: AppUtil.getWidth(context) / 1.6,
          minHeight: AppUtil.getHeight(context) / 6.5,
          maxHeight: AppUtil.getHeight(context) / 5,
        ),
        decoration: BoxDecoration(
          color: ColorUtil.MAIN_COLOR,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 22,
                ),
                child: SimpleText(
                  textColor: ColorUtil.WHITE,
                  optionalTextSize: 20,
                  text: "Lorem ipsum lorem ipsum sit amed lorem ipsum",
                ),
              ),
            ),
            const CalcSizedBox(calc: 20),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(
                  left: AppUtil.getWidth(context) / 20,
                  right: AppUtil.getWidth(context) / 20,
                  top: 6,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SimpleText(
                      textColor: ColorUtil.WHITE,
                      textIsNormal: true,
                      optionalTextSize: 18,
                      text: "19/07/2022",
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
