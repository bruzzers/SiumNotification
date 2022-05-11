import 'package:easy_localization/easy_localization.dart';
import 'package:sium_notification/utils/date/date_utils.dart';

class DateUtilsImpl extends DateUtils{
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

}