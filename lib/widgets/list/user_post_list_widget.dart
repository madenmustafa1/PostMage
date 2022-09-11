import 'package:flutter/material.dart';
import '/widgets/list/post_bottom_row.dart';
import '/widgets/image/show_list_image.dart';
import '/widgets/widget_util/box_decorations.dart';
import '/dependency_injection/setup.dart';
import '/util/app_util.dart';
import '/util/color_util.dart';
import '/util/constants.dart';
import '../widget_util/box_decoration.dart';
import '../widget_util/calc_sized_box.dart';
import '/widgets/text_and_button/simple_text.dart';

class UserPostListWidget extends StatelessWidget {
  UserPostListWidget({Key? key}) : super(key: key);

  final Constants constants = getIt<Constants>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppUtil.getHeight(context) / 1.2,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.vertical,
            itemBuilder: (_, item) => listViewItem(context, item),
          ),
        ),
      ],
    );
  }

  Widget listViewItem(BuildContext context, int item) {
    return Column(
      children: [
        const CalcSizedBox(calc: 100),
        SizedBox(
          child: Container(
            constraints: boxConstraintsList(context),
            decoration: BoxDecorationWidgetUtil.borderRadius(borderRadius: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showListImage(context: context, item: item),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 15,
                  ),
                  child: SimpleText(
                    textColor: ColorUtil.WHITE,
                    optionalTextSize: 20,
                    text: "Mustafa Maden",
                    textIsNormal: true,
                  ),
                ),
                userImageDescription(),
                const CalcSizedBox(calc: 50),
                const PostBottomRowWidget(),
                const CalcSizedBox(calc: 180),
                likeSizeText()
              ],
            ),
          ),
        ),
        const CalcSizedBox(calc: 50),
      ],
    );
  }

  Flexible userImageDescription() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: SimpleText(
          textColor: ColorUtil.WHITE,
          optionalTextSize: 20,
          text: "Lorem ipsum lorem ipsum sit amed lorem ipsum",
          textIsNormal: true,
        ),
      ),
    );
  }

  Widget likeSizeText() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: SimpleText(
          text: "Liked by Mustafa Maden and 27 other",
          optionalTextSize: 16,
          textColor: ColorUtil.WHITE,
          textIsNormal: true,
        ),
      ),
    );
  }
}
