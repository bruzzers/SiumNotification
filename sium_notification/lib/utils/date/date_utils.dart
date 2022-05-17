abstract class SiumDateUtils{
  String? parseStringDate(DateTime? date);
  DateTime parseStringToDateTime(String? date);
  DateTime? getNowDate();
  String? getNowDateForFirebase(DateTime? now);
}