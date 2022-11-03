import '../../model/profile/group_profile_info.dart';
import '../../services/data_layer.dart';
import '../../util/constants.dart';
import '/dependency_injection/setup.dart';
import '/services/repo/app_http_repository.dart';

class ProfileViewModel {
  final AppHttpRepository _appHttpRepository = getIt<AppHttpRepository>();
  final Constants constants = getIt<Constants>();

  Future<DataLayer<UserProfileInfoModel?>> getMyProfileInfo() async {
    try {
      var data = await _appHttpRepository.getMyProfileInfo();
      return data;
    } catch (e) {
      return DataLayer(
        errorData: ErrorData(
          reason: constants.TR_GENERAL_ERROR,
          statusCode: DataStatus.ERROR,
        ),
      );
    }
  }
}
