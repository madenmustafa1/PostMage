import 'package:flutter/material.dart';
import 'package:mdntls/util/color_util.dart';
import 'package:mdntls/util/permission_util.dart';
import 'package:mdntls/util/router.dart';
import 'package:mdntls/widgets/text_and_button/simple_text.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '/util/app_util.dart';
import '/widgets/column_and_row/custom_icon_row.dart';
import '/widgets/widget_util/calc_sized_box.dart';
import '/widgets/appbar/basic_appbar.dart';
import '/dependency_injection/setup.dart';
import '/util/constants.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final Constants constants = getIt<Constants>();

  final PermissionUtil _permissionUtil = getIt<PermissionUtil>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => _permissionUtil.permissonCameraHandler(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: constants.addUserPageTitle),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppUtil.getWidth(context) / 12,
          ),
          child: SizedBox(
            width: AppUtil.getWidth(context),
            height: AppUtil.getHeight(context) / 1.25,
            child: Column(
              children: [
                const CalcSizedBox(calc: 9),
                CustomIconRow(
                  title: constants.addUserPageSearchUserId,
                  icon: const Icon(Icons.edit, size: 30),
                  callback: () {},
                ),
                const CalcSizedBox(calc: 80),
                CustomIconRow(
                  title: constants.addUserPageScanQR,
                  icon: const Icon(Icons.qr_code_scanner_sharp, size: 30),
                  callback: () {
                    Navigator.pushNamed(context, CRouter.QR_CODE);
                  },
                ),
                const CalcSizedBox(calc: 14),
                Divider(
                  color: ColorUtil.BLACK,
                  thickness: 1.5,
                ),
                const CalcSizedBox(calc: 70),
                SimpleText(
                  text: "#mustafa_maden",
                  optionalTextSize: AppUtil.getHeight(context) / 20,
                ),
                const CalcSizedBox(calc: 80),
                PrettyQr(
                  image: const AssetImage('assets/images/qr_code_icon.png'),
                  typeNumber: 3,
                  size: 250,
                  data: 'https://www.google.com',
                  errorCorrectLevel: QrErrorCorrectLevel.M,
                  roundEdges: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
