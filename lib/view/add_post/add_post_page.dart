// ignore_for_file: must_be_immutable

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '/widgets/text_and_button/switch_button.dart';
import '/widgets/widget_util/show_toast.dart';
import '/widgets/text_and_button/rich_text_field.dart';
import '/widgets/text_and_button/simple_button.dart';
import '/widgets/widget_util/calc_sized_box.dart';
import '/widgets/widget_util/appbar_border_radius.dart';
import '/dependency_injection/setup.dart';
import '/util/constants.dart';
import '/widgets/text_and_button/simple_text.dart';
import '/util/color_util.dart';
import 'add_post_view_model.dart';
import 'add_post_widgets/add_post_image.dart';

class AddPostPage extends ConsumerStatefulWidget {
  AddPostPage({
    Key? key,
    this.groupId,
  }) : super(key: key);

  String? groupId;

  @override
  AddPostPageState createState() => AddPostPageState();
}

class AddPostPageState extends ConsumerState<AddPostPage> {
  final Constants constants = getIt<Constants>();

  TextEditingController content = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  Uint8List? selectedImageBytes;
  AddPostViewModel viewModel = getIt<AddPostViewModel>();
  bool privateShareSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SimpleText(
          text: constants.addPostAppTitle,
          optionalTextSize: 25,
          textColor: ColorUtil.WHITE,
        ),
        backgroundColor: ColorUtil.MAIN_COLOR,
        shadowColor: null,
        shape: AppbarWidgetUtil.appbarBorderRadius(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CalcSizedBox(calc: 20),
              AddPostImage(
                selectedImageBytes: selectedImageBytes,
                callback: () {
                  takePhoto();
                },
              ),
              const CalcSizedBox(calc: 40),
              RichTextField(
                controller: content,
                hintText: constants.TR_MAKE_COMMENT,
                maxlines: 3,
              ),
              const CalcSizedBox(calc: 100),
              CustomSwitchButton(
                  text: "Özel paylaş",
                  switchCallback: (switchValue) {
                    privateShareSwitched = switchValue;
                  }),
              const CalcSizedBox(calc: 20),
              SimpleButton(
                buttonText: constants.TR_SAVE,
                onPressed: () {
                  saveButton();
                },
              ),

              //ListView
              //HomePagePastOrderList()
            ],
          ),
        ),
      ),
    );
  }

  XFile? pickedFile;
  Future<void> takePhoto() async {
    try {
      pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        //maxWidth: maxWidth,
        //maxHeight: maxHeight,
        //imageQuality: quality,
      );

      if (pickedFile != null) {
        selectedImageBytes = await pickedFile!.readAsBytes();
        if (selectedImageBytes == null) return;
        setState(() {});
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  void saveButton() async {
    var result = await viewModel.sharePost(
      selectedImageBytes,
      content.text,
      pickedFile,
      widget.groupId,
    );

    if (result) {
      ShowToast.successToast(constants.TR_SHARED_SUCCESSFULLY);
      Navigator.maybePop(context, true);
    } else {
      ShowToast.errorToast(constants.TR_GENERAL_ERROR);
    }
  }
}
