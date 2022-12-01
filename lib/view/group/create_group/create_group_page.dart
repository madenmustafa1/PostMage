// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mdntls/services/data_layer.dart';
import '../../../widgets/appbar_and_bottombar/basic_appbar.dart';
import '/widgets/widget_util/show_toast.dart';
import '../group_viewmodel.dart';
import '/widgets/text_and_button/rich_text_field.dart';
import '/widgets/text_and_button/simple_button.dart';
import '/widgets/widget_util/calc_sized_box.dart';
import '../../add_post/add_post_widgets/add_post_image.dart';
import '/dependency_injection/setup.dart';
import '/util/constants.dart';

class CreateGroupPage extends ConsumerStatefulWidget {
  CreateGroupPage({
    Key? key,
  }) : super(key: key);

  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends ConsumerState<CreateGroupPage> {
  Constants constants = getIt<Constants>();
  Uint8List? selectedImageBytes;
  TextEditingController content = TextEditingController();
  final GroupViewModel _groupViewModel = getIt<GroupViewModel>();

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: constants.groupsTitle,
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
                hintText: constants.groupName,
                maxlines: 3,
              ),
              const CalcSizedBox(calc: 100),

              const CalcSizedBox(calc: 20),
              SimpleButton(
                buttonText: constants.TR_SAVE,
                onPressed: () {
                  saveButton();
                },
              ),
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
    var result = await _groupViewModel.createGroup(content.text, pickedFile);

    if (result.status == DataStatus.SUCCESS) {
      ShowToast.successToast(constants.createCroupSuccess);
      Navigator.maybePop(context, true);
    } else {
      var message = result.errorData?.reason ?? "";
      if (message == "") message = constants.TR_GENERAL_ERROR;
      ShowToast.errorToast(
        message,
      );
    }
  }
}
