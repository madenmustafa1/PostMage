import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mdntls/services/data_layer.dart';
import 'package:mdntls/widgets/post/comment_bottom_widget.dart';
import 'package:mdntls/widgets/widget_util/show_toast.dart';
import '../../../model/posts/get_user_post_model.dart';
import '../../../provider/post/comment_provider.dart';
import '../../../provider/post/post_provider.dart';
import '../../../widgets/image/customize_image_widget.dart';
import '../../../widgets/text_and_button/simple_text.dart';
import '/../../util/color_util.dart';
import '/../../view/post/post_viewmodel.dart';
import '/../../widgets/appbar_and_bottombar/basic_appbar.dart';
import '../../../dependency_injection/setup.dart';
import '../../../util/constants.dart';

class CommentsPage extends ConsumerStatefulWidget {
  CommentsPage({
    Key? key,
    required this.objectId,
  }) : super(key: key);

  final String objectId;
  final Constants _constants = getIt<Constants>();
  final PostViewModel _postViewModel = getIt<PostViewModel>();

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends ConsumerState<CommentsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ref.read(commentProvider.notifier).resetComments();
      getPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    var model = ref.watch(commentProvider);
    return Scaffold(
      appBar: BasicAppBar(
        title: widget._constants.commentsPageTitle,
      ),
      backgroundColor: ColorUtil.BACKGROUND_COLOR,
      body: Column(
        children: [
          model != null
              ? commentWidget(model)
              : const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  void getPost() async {
    var result = await widget._postViewModel.getComments(widget.objectId);

    if (result.status == DataStatus.SUCCESS && result.data != null) {
      ref.read(commentProvider.notifier).updateComments(result.data!);
    } else {
      ShowToast.errorToast(
        result.errorData?.reason ?? widget._constants.TR_GENERAL_ERROR,
      );
    }
  }

  Widget commentWidget(List<Comment> model) {
    return Expanded(
      child: ListView.builder(
        itemCount: model.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CustomizeImageWidget(
                  photoName: model[index].photoName ?? "",
                  width: 40,
                  height: 40,
                ),
                title: SimpleText(
                  text: model[index].nameSurname ?? "",
                  textIsNormal: true,
                  optionalTextSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SimpleText(
                  text: "text",
                  textIsNormal: true,
                  optionalTextSize: 20,
                ),
              ),
              CommentBottomRowWidget(model: model[index]),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(thickness: 1),
              ),
            ],
          );
        },
      ),
    );
  }
}
