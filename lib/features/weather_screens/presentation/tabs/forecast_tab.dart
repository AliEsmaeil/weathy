import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathy/core/utils/components/animated_loading_container.dart';
import 'package:weathy/core/utils/extensions/current_day_extension.dart';
import 'package:weathy/features/weather_screens/presentation/helpers/day_weather_card.dart';
import 'package:weathy/features/weather_screens/presentation/helpers/hour_weather_card.dart';

import '../../../../core/assets/icons/weather_icons_icons.dart';
import '../../../../core/utils/inner_models/representable_data.dart';
import '../controllers/current_weather_cubit/cubit.dart';
import '../controllers/current_weather_cubit/states.dart';
import '../helpers/details_card.dart';

class PredictionTab extends StatelessWidget {
  PredictionTab({super.key});

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
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              primary: true,
              pinned: false,
              floating: false,
              flexibleSpace:  FlexibleSpaceBar(
                    title: Text(
                      'Tomorrow Hours',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    background: FutureBuilder(
                      future: cubit.getTomorrowWeatherForecasts(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            state is! HomeScreenLoadingState) {
                          var dataSource = <RepresentableData>[
                            for (int i = 0; i <= 23; i++)
                              RepresentableData(
                                  value: i, // hour
                                  category: snapshot.data!.hoursOverDay[i].temp // temperature in that hour
                              )
                          ];
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: dataSource.length,
                            itemBuilder: (context, index) {
                              return HourWeatherCard(
                                  hour: dataSource[index].value as int,
                                  imageUrl: snapshot.data!.hoursOverDay[index].condition.weatherIcon,
                                  temperature: dataSource[index].category.toString(),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text(
                                  'Error , tomorrow forecasts , ${snapshot.error} ... ${snapshot.stackTrace}'));
                        } else {
                          return Container(
                            height: MediaQuery.of(context).size.height / 4,
                            child: Row(
                              children: [
                                Expanded(child: AnimatedLoadingContainer()),
                                Expanded(child: AnimatedLoadingContainer()),
                                Expanded(child: AnimatedLoadingContainer()),
                                Expanded(child: AnimatedLoadingContainer()),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
              expandedHeight: MediaQuery.of(context).size.height / 3.5,
            ),

            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width / 2,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1.5,
                title: Text('Coming Days',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.grey,
                    )),
                background: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.black,
                        Colors.black12,
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: CachedNetworkImage(
                    placeholder: (context, str)=>AnimatedLoadingContainer(),
                    imageUrl: //
                        'https://images.unsplash.com/photo-1504608524841-42fe6f032b4b?',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        Icon(Icons.image_not_supported_rounded),
                    errorListener: (error) {
                      debugPrint(
                          'ERROR IN CACHED NETWORK IMAGE (forecast tab) : $error');
                    },
                  ),
                ),
              ),
              actions: [
                    IconButton(
                      icon: Icon(
                        Icons.light_mode_rounded,
                      ),
                      onPressed: () {
                        cubit.changeThemeMode();
                      },
                    ),
              ],
              pinned: true,
              stretch: true,
              floating: true,
            ),

            SliverList.list(
              children: [
                FutureBuilder(
                  future: cubit.getComingDayForecasts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && state is! HomeScreenLoadingState)
                    {
                      var dataSource = [
                        for (int i = 0;
                            i < snapshot.data!.comingDaysForecast.length;
                            i++)
                          RepresentableData(
                              category: DateTime.parse(
                                      snapshot.data!.comingDaysForecast[i].date)
                                  .getDayName(),
                              value: snapshot
                                  .data!.comingDaysForecast[i].day.maxTemp)
                      ];

                      return Column(
                        children: [
                          for (int i = 0;
                              i < snapshot.data!.comingDaysForecast.length;
                              i++)
                            DayWeatherCard(
                                date: snapshot.data!.comingDaysForecast[i].date,
                                dayName: dataSource[i].category,
                                weatherImageUrl: snapshot.data!.comingDaysForecast[i].day.condition.weatherIcon,
                                temperature: ((snapshot.data!.comingDaysForecast[i].day.maxTemp + snapshot.data!.comingDaysForecast[i].day.minTemp) / 2).toStringAsFixed(1).toString(),
                                weatherDescription: snapshot.data!.comingDaysForecast[i].day.condition.weatherDescription,
                                windSpeed: snapshot.data!.comingDaysForecast[i].hoursOverDay[i].windSpeed.toString(),
                                humidity: snapshot.data!.comingDaysForecast[i].hoursOverDay[i].humidity.toString(),
                                feelsLike: snapshot.data!.comingDaysForecast[i].hoursOverDay[i].feelsLike.toString(),
                                rainChance: snapshot.data!.comingDaysForecast[i].hoursOverDay[i].rainChance.toString(),
                            ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                              'Error coming days forecasts, ${snapshot.error} ... ${snapshot.stackTrace}'));
                    }
                    return Column(
                      children: [for(int i = 0 ; i <10 ; i++) SizedBox(
                          height: MediaQuery.of(context).size.width,
                          child: AnimatedLoadingContainer())],
                    );
                  },
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
