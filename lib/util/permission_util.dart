import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  void permissonCameraHandler() async {
    await [
      Permission.camera,
    ].request();
    /*
    Map<Permission, PermissionStatus> statuses =
    var status = await Permission.camera.request();
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      return;
    } else {
      return;
    }
    */
  }
}
