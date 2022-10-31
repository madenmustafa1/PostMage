class DateUtil {
  static String convertTimeMillisToDate(int? timeMillis) {
    if (timeMillis == null) return "";
    var date = DateTime.fromMillisecondsSinceEpoch(timeMillis);

    return date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
  }
}
