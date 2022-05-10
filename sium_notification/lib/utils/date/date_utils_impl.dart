import 'package:easy_localization/easy_localization.dart';
import 'package:sium_notification/utils/date/date_utils.dart';

class DateUtilsImpl extends DateUtils{
  @override
  String? parseStringDate(String? date) {
    final parseDate = DateTime.tryParse(date ?? "");
    if (parseDate != null) {
      return DateFormat("dd/MM/yyyy, HH:mm").format(parseDate);
    } else {
      return null;
    }
  }

}