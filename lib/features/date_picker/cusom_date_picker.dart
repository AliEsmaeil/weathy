import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../weather_screens/presentation/helpers/list_wheel_view.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ScrollWheelDatePicker extends StatelessWidget {

  final void Function(String) onYearChange;
  final void Function(String) onMonthChange;
  final void Function(String) onDayChange;

  const ScrollWheelDatePicker({super.key, required this.onYearChange , required this.onMonthChange , required this.onDayChange});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=> DatePickerCubit(),
      child: BlocConsumer<DatePickerCubit,DatePickerStates>(
        listener: (context,state){},
        builder:(context,state){
          var cubit = DatePickerCubit.getCubit(context);

          return  Row(
            children: [
              // every list wheel will allocate 1/3 of width and the same of height
              ListWheel(
                controller: cubit.controller,
                onSelectedItemChanged: (int index){
                  cubit.changeYear(index);
                  onYearChange(cubit.getChosenDate);
                },
                title: 'Year',
                children: cubit.years.map((e) => Text(e.toString())).toList(),
              ),

              ListWheel(
                title: 'Month',
                onSelectedItemChanged: (index){
                  cubit.changeMonth(index);
                  onMonthChange(cubit.getChosenDate);
                },
                children: cubit.months.map((e) => Text(e.monthNumber.toString())).toList(),
              ),
              ListWheel(
                title: 'Day',
                onSelectedItemChanged: (index){ // zero based: it's a list (index refers to item's index).
                  cubit.changeDay(index+1);
                  onDayChange(cubit.getChosenDate);
                },
                children: [for(int i = cubit.getStartDay; i<= cubit.chosenMonth!.maxDays;i++)Text(i.toString())],
              ),

            ],
          );
      },
      ),
    );
  }
}
