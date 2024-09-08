import 'package:intl/intl.dart';

extension CurrentDay on DateTime{

  String getDayName(){
    DateFormat dateFormat =   DateFormat('EEEE');
    return dateFormat.format(this);
  }

  String getDateInAPIFormat(){
    DateFormat format = DateFormat('yyyy-MM-dd');

    return format.format(this);
  }
}