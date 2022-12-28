// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widget_util/show_toast.dart';
import '/widgets/list/list_item/like_size_text.dart';
import '/enum/list_type.dart';
import '/model/posts/get_user_post_model.dart';
import '/view/home/home_view_model.dart';
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
import 'list_item/user_image_description.dart';

class UserPostListWidget extends ConsumerStatefulWidget {
  UserPostListWidget({
    Key? key,
    required this.listType,
  }) : super(key: key);

  final ListType listType;
  final Constants _constants = getIt<Constants>();
  final HomeViewModel _homeViewModel = getIt<HomeViewModel>();

  @override
  _UserPostListWidget createState() => _UserPostListWidget();
}

class _UserPostListWidget extends ConsumerState<UserPostListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppUtil.getHeight(context) / 1.27,
          child: FutureBuilder(
            future: _observeData(),
            builder: (
              BuildContext context,
              AsyncSnapshot<List<GetUserPostModel?>?> snapshot,
            ) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (snapshot.hasError) {
                    ShowToast.errorToast(widget._constants.TR_GENERAL_ERROR);
                    return Container();
                  } else {
                    return ListView.builder(
                      itemCount:
                          snapshot.data != null ? snapshot.data!.length : 0,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, item) => listViewItem(
                        context,
                        item,
                        snapshot.data![item],
                      ),
                    );
                  }
              }
            },
          ),
        ),
      ],
    );
  }

  Widget listViewItem(
    BuildContext context,
    int item,
    GetUserPostModel? model,
  ) {
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
                showListImage(
                  context: context,
                  photoName: model?.photoName ?? "",
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 15,
                  ),
                  child: SimpleText(
                    textColor: ColorUtil.WHITE,
                    optionalTextSize: 20,
                    text: model?.nameSurname ?? "",
                    textIsNormal: true,
                  ),
                ),
                UserImageDescription(model: model),
                const CalcSizedBox(calc: 50),
                PostBottomRowWidget(model: model),
                const CalcSizedBox(calc: 100),
                LikeSizeText(model: model)
              ],
            ),
          ),
        ),
        const CalcSizedBox(calc: 50),
      ],
    );
  }

  Future<List<GetUserPostModel?>?> _observeData() async {
    return await widget._homeViewModel.getUsersPosts(listType: widget.listType);
  }
}
