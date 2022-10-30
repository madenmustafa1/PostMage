// ignore_for_file: constant_identifier_names

class DataLayer<T> {
  DataLayer({
    this.data,
    this.errorData,
    this.status,
  });
  T? data;
  ErrorData? errorData;
  DataStatus? status;
}

enum DataStatus {
  SUCCESS,
  FAILED,
  LOADING,
  LOADED,
  ERROR,
  STARTED,
  FINISH,
  WAIT,
  BLOCKED,
  UNAUTHORIZED,
}

class ErrorData {
  String reason;
  DataStatus statusCode;
  ErrorData({
    required this.reason,
    required this.statusCode,
  });
}
