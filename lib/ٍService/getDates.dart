import 'package:intl/intl.dart';

String getDateofnow() {
  var now = DateTime.now();
  //to write the name of the day write mmm ,,,, iif mm will write num
  var dateFormat = DateFormat('dd MMM yyyy  @ hh:mm').format(now);
  return dateFormat;
}

getDateofdaywithoutHH() {
  var now = DateTime.now();
  //to write the name of the day write mmm ,,,, iif mm will write num
  var dateFormat = DateFormat('dd MMM yyyy ').format(now);
  return dateFormat;
}
