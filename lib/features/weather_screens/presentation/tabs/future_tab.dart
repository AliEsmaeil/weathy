
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathy/core/utils/components/animated_loading_container.dart';
import 'package:weathy/core/utils/components/spline_area_chart.dart';
import 'package:weathy/core/utils/extensions/current_day_extension.dart';
import 'package:weathy/features/weather_screens/presentation/helpers/day_weather_card.dart';
import 'package:weathy/features/weather_screens/presentation/helpers/hour_weather_card.dart';

import '../../../../core/assets/icons/weather_icons_icons.dart';
import '../../../../core/utils/inner_models/representable_data.dart';
import '../../../date_picker/cusom_date_picker.dart';
import '../controllers/current_weather_cubit/cubit.dart';
import '../controllers/current_weather_cubit/states.dart';
import '../helpers/details_card.dart';

class FutureWeatherForecast extends StatelessWidget {
String startDate = DateTime.now().add(Duration(days: 200)).getDateInAPIFormat();

FutureWeatherForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeScreenCubit.getCubit(context);

          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: MediaQuery.of(context).size.width / 4,
                actions: [
                  IconButton(
                      onPressed: () {
                        cubit.changeThemeMode();
                      },
                      icon: Icon(Icons.light_mode_rounded)),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1.2,
                  title: Text(
                    'Date Forecasting',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ),
              ),

              SliverList.list(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Explore Future Weather for next 10 months',
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).brightness == Brightness.light?
                            Colors.grey.shade200 : Colors.grey.shade800,
                      ),
                      child: ScrollWheelDatePicker(
                        onYearChange: (date){
                         startDate = date;
                        },
                        onMonthChange: (date){
                          startDate = date;
                        },
                        onDayChange: (date){
                          startDate = date;
                        },
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                        onPressed: () {
                          if(startDate != DateTime.now().add(Duration(days: 250)).getDateInAPIFormat()){
                            cubit.getFutureDay(startDate);
                          }
                        },
                        child: Text('Forecast')),
                  ),

                  FutureBuilder(
                    future: cubit.getFutureDayWeather(date: startDate),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && state is! HomeScreenLoadingState) {

                        int index = 0;
                        return Column(
                          children: [
                            // day weather card must be reusable

                            // snapshot.data!.date
                            //DateTime.parse(snapshot.data!.date).getDayName()
                            //
                            DayWeatherCard(
                                date: snapshot.data!.date,
                                dayName: DateTime.parse(snapshot.data!.date).getDayName() ,
                                weatherImageUrl: snapshot.data!.day.condition.weatherIcon,
                                temperature: snapshot.data!.day.maxTemp.toString(),
                                weatherDescription: snapshot.data!.day.condition.weatherDescription,
                                windSpeed: snapshot.data!.hoursOverDay[0].windSpeed.toString(),
                                humidity: snapshot.data!.hoursOverDay[0].humidity.toString(),
                                feelsLike: snapshot.data!.hoursOverDay[0].feelsLike.toString(),
                                rainChance: snapshot.data!.day.rainChance.toString(),
                            ),

                            SmoothAreaChart(
                              yAxisTitle: 'C',
                              xAxisTitle: 'Hour',
                              chartTitle: 'Day Temperature',
                              dataSource: snapshot.data!.hoursOverDay
                                  .map((hour) => RepresentableData(
                                      value: hour.feelsLike, category: index++))
                                  .toList(),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Hour Temperature over Day',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                              )
                              ),
                            ),
                            // day hours temp must be reusable
                            Container(
                              height: MediaQuery.of(context).size.width/2,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.hoursOverDay.length,
                                itemBuilder: (context, index) {
                                  return HourWeatherCard(
                                      hour: index,
                                      imageUrl: snapshot.data!.hoursOverDay[index].condition.weatherIcon,
                                      temperature: snapshot.data!.hoursOverDay[index].temp.toString(),
                                  );
                                },
                              ),
                            ),

                          ],
                        );
                      }
                      else if (snapshot.hasError) {
                        print(snapshot.error.toString());
                        return Center(child: Text('Error , future day weather , ${snapshot.error} ... ${snapshot.stackTrace}'));
                      } else {
                        return Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width,
                              width: double.infinity,
                              child: const  AnimatedLoadingContainer(),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width,
                              width: double.infinity,
                              child: const  AnimatedLoadingContainer(),
                            ),
                            Row(
                              children: [
                                for(int i = 0 ; i < 4; i++)
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width/2,
                                      width: MediaQuery.of(context).size.width/4,
                                      child: AnimatedLoadingContainer())
                              ],
                            )

                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }
}

