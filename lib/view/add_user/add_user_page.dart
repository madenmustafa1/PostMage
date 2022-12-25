import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/appbar_and_bottombar/basic_appbar.dart';
import '/services/data_layer.dart';
import '/widgets/widget_util/show_toast.dart';
import '/model/profile/following_model.dart';
import '/model/profile/put_follower_data.dart';
import '/model/profile/group_profile_info.dart';
import '/provider/profile/profile_page_provider.dart';
import '../profile/profile_viewmodel.dart';
import '/util/color_util.dart';
import '/util/permission_util.dart';
import '/util/router.dart';
import '/widgets/text_and_button/simple_text.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '/util/app_util.dart';
import '/widgets/column_and_row/custom_icon_row.dart';
import '/widgets/widget_util/calc_sized_box.dart';
import '/dependency_injection/setup.dart';
import '/util/constants.dart';

class AddUserPage extends ConsumerStatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends ConsumerState<AddUserPage> {
  final Constants constants = getIt<Constants>();

  final PermissionUtil _permissionUtil = getIt<PermissionUtil>();

  final ProfileViewModel _profileViewModel = getIt<ProfileViewModel>();
  UserProfileInfoModel? _userProfileModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _permissionUtil.permissonCameraHandler(),
    );
    _userProfileModel = ref.read(getProfileInfoProvider);
  }

  @override
  Widget build(BuildContext context) {
    getMyProfileInfo();
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
                /*
                CustomIconRow(
                  title: constants.addUserPageSearchUserId,
                  icon: const Icon(Icons.edit, size: 30),
                  callback: () {},
                ),
                */
                const CalcSizedBox(calc: 80),
                CustomIconRow(
                  title: constants.addUserPageScanQR,
                  icon: const Icon(Icons.qr_code_scanner_sharp, size: 30),
                  callback: () async {
                    var result =
                        await Navigator.pushNamed(context, CRouter.QR_CODE);
                    if (result != null) addUser(result);
                  },
                ),
                const CalcSizedBox(calc: 14),
                Divider(
                  color: ColorUtil.BLACK,
                  thickness: 1.5,
                ),
                const CalcSizedBox(calc: 70),
                SimpleText(
                  text: "#" + (_userProfileModel?.nameSurname ?? ""),
                  optionalTextSize: AppUtil.getHeight(context) / 20,
                ),
                const CalcSizedBox(calc: 80),
                PrettyQr(
                  image: const AssetImage('assets/images/qr_code_icon.png'),
                  typeNumber: 3,
                  size: 250,
                  data: _userProfileModel?.userId ?? "",
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

  void getMyProfileInfo() async {
    if (_userProfileModel != null) return;
    _userProfileModel = ref.watch(getProfileInfoProvider);

    var model = await _profileViewModel.getMyProfileInfo();
    if (model.data != null && _userProfileModel == null) {
      _userProfileModel = model.data;
      ref.read(getProfileInfoProvider.notifier).update(model.data);
    }
  }

  void addUser(Object? userId) async {
    if (_userProfileModel == null || userId == null) return;
    var model =
        PutFollowerDataModel(following: Following(userId: userId.toString()));
    var res = await _profileViewModel.putFollowerData(model);

    if (res.status == DataStatus.SUCCESS) {
      ShowToast.successToast(constants.adduserSuccessfully);
      Navigator.maybePop(context, true);
    } else {
      ShowToast.errorToast(constants.TR_GENERAL_ERROR);
    }
  }
}
