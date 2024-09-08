
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathy/features/date_picker/cubit/states.dart';

final class DatePickerCubit extends Cubit<DatePickerStates>{

  final ScrollController controller = FixedExtentScrollController();

  final marginYear = DateTime.now().add(Duration(days: 300)).year;
  final marginMonth =  DateTime.now().add(Duration(days: 300)).month;
  final marginDay =  DateTime.now().add(Duration(days: 300)).day;

  // after 300 days date will be 19-03-2025

  List<int> years = [];
  List<Month> months = [];

  Month? chosenMonth ;
  int chosenYear = DateTime.now().year;
  int chosenDay = DateTime.now().day;

  DatePickerCubit():super(DatePickerInitialState()){
    initiateDate();
  }

  static DatePickerCubit getCubit(BuildContext context)=>BlocProvider.of(context);

  void initiateDate(){
    initiateYears();
    initiateMonths();

  }
  void initiateYears(){
    if(marginYear == DateTime.now().year){
      years = [marginYear]; // example : 2024
    }
    else{ // 10 months never exceed a year
      years = [DateTime.now().year, marginYear,]; // example : 2024 . 2025
    }
  }
  void initiateMonths(){
    int counter = 0 ;
    for(int i = DateTime.now().month ; i <= 12 && counter<10 ; i++){
      // get maximum number of days in a month
      months.add(Month(DateTime(DateTime.now().year, (i ==12)? 1 : i+1,0).day, i));
      counter++;
    }
    if(counter < 10){
      int diff = 10 - counter;
      for(int i =1 ; i < diff ; i++){
        months.add(Month(DateTime(marginYear,i+1,0).day, i));
        if(months.length == 10){
          break;
        }
      }
    }
    chosenMonth = months[0];
  }

  int get getStartDay{
    if(chosenMonth == months[0])
      return DateTime.now().day+1;
    else
      return 1;
  }

  void changeYear(int index){
    chosenYear = years[index];
    checkDateValidity();
    emit(DatePickerChangedYearState());
  }
  void checkDateValidity()async{
    // if the user choose date that exceeds 10 months forward (minimize the chosen date by a year)
    if(DateTime.now().add(Duration(days: 300)).compareTo(DateTime(chosenYear, chosenMonth!.monthNumber,chosenDay)) < 0){
      await controller.animateTo(controller.position.minScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.ease);

    }
    if (DateTime(chosenYear, chosenMonth!.monthNumber,chosenDay).compareTo(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,)) < 0){
      await controller.animateTo(controller.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.ease);

    }
  }

  void changeMonth(int index){
    chosenMonth = months[index];
    chosenDay = chosenMonth!.monthNumber > DateTime.now().month ? 1 : DateTime.now().day;
    checkDateValidity();
    emit(DatePickerChangedMonthState());
  }
  void changeDay(int day){
    chosenDay = day;
  }

  String get getChosenDate{
    String month = chosenMonth!.monthNumber.toString() ;

    if(month.length ==1)
    {
     month = '0$month';
    }
    String date = '$chosenYear-$month-${chosenDay}';
    return date;
  }


}


class Month{
  int monthNumber;
  int maxDays;
  Month(this.maxDays,this.monthNumber);
}