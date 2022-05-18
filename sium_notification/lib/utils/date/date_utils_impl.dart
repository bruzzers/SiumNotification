import 'package:easy_localization/easy_localization.dart';
import 'package:sium_notification/utils/date/date_utils.dart';

class DateUtilsImpl extends SiumDateUtils{
  @override
  String? parseStringDate(DateTime? date) {
    if (date != null) {
      return DateFormat("dd/MM/yyyy, HH:mm").format(date);
    } else {
      return null;
    }
  }

  @override
  DateTime parseStringToDateTime(String? date) {
    return DateTime.parse(date ?? "");
  }

  @override
  String? getNowDateForFirebase(DateTime? now) {

    if(now != null) {
      return DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    }else{
      return "";
    }
  }

  @override
  DateTime? getNowDate() {
    return DateTime.now();
  }

}