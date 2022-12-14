import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/../../services/data_layer.dart';
import '/../../widgets/post/comment_bottom_widget.dart';
import '/../../widgets/widget_util/show_toast.dart';
import '../../../model/posts/get_user_post_model.dart';
import '../../../widgets/image/customize_image_widget.dart';
import '../../../widgets/text_and_button/rich_text_field.dart';
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
  Constants constants = getIt<Constants>();
  TextEditingController commentController = TextEditingController();
  DataLayer<List<Comment>?> commentList = DataLayer(status: DataStatus.LOADING);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: widget._constants.commentsPageTitle,
      ),
      backgroundColor: ColorUtil.BACKGROUND_COLOR,
      body: Stack(
        children: [
          Column(
            children: [
              FutureBuilder(
                future: getPost(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<DataLayer<List<Comment>?>> snapshot,
                ) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      if (snapshot.hasError) {
                        ShowToast.errorToast(
                          snapshot.data?.errorData?.reason ??
                              widget._constants.TR_GENERAL_ERROR,
                        );
                        return Container();
                      } else {
                        return commentWidget(snapshot.data?.data);
                      }
                  }
                },
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: RichTextField(
                      controller: commentController,
                      hintText: constants.addComment,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send_rounded),
                        onPressed: () => addComment(),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Future<DataLayer<List<Comment>?>> getPost() async {
    return widget._postViewModel.getComments(widget.objectId);
  }

  Widget commentWidget(List<Comment>? model) {
    if (model == null) return Container();
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

  void addComment() {
    // TODO:  user-posts/update-posts
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
