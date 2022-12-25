import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  Future<Map<Permission, PermissionStatus>> permissonCameraHandler() async {
    return await [
      Permission.camera,
      Permission.mediaLibrary,
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
