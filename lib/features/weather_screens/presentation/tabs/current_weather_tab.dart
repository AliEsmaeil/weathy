
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathy/features/loading_animation/current_weather_bottom_part.dart';
import 'package:weathy/features/loading_animation/current_weather_top_part.dart';
import '../../../../core/assets/icons/weather_icons_icons.dart';
import '../../../../core/utils/components/spline_area_chart.dart';
import '../../../../core/utils/inner_models/representable_data.dart';
import '../controllers/current_weather_cubit/cubit.dart';
import '../controllers/current_weather_cubit/states.dart';
import '../helpers/city_search_bar.dart';
import '../helpers/details_card.dart';

class CurrentWeatherTab extends StatelessWidget {

  CurrentWeatherTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit,HomeScreenStates>(
      listener: (context,state){},
      builder: (context,state){

        var cubit = HomeScreenCubit.getCubit(context);
           return RefreshIndicator(
             onRefresh: ()async{
               cubit.updateDataModels();
             },
             color: Theme.of(context).scaffoldBackgroundColor == Colors.white? Colors.black : Colors.white,
             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
             child: SingleChildScrollView(
               child: Column(
                 children: [
                   CitySearchBar(),
                   Container(
                     height: MediaQuery.of(context).size.height *
                         (2 / 3),
                     child: FutureBuilder(
                       future: cubit.getCurrentWeather(), // just test
                       builder: (context, snapshot) {
                         if (snapshot.hasData && state is! HomeScreenLoadingState) {
                           return Column(
                             children: [
                               Expanded(
                                   child: Column(
                                     children: [
                                       Padding(
                                         padding: EdgeInsets.fromLTRB(
                                             0, 20, 0, 10),
                                         child: Text(
                                           softWrap: false,
                                           overflow: TextOverflow.clip,
                                           snapshot.data!.location.subAdministrativeArea?? snapshot.data!.location.cityName,
                                           style: Theme.of(context)
                                               .textTheme
                                               .titleMedium,
                                         ),

                                       ),
                                       Row(
                                         mainAxisAlignment:
                                         MainAxisAlignment.center,
                                         children: [
                                           CachedNetworkImage(
                                             imageUrl:  'https:${snapshot.data!.current.condition.weatherIcon}',
                                             fit: BoxFit.cover,
                                             errorWidget: (context,url,error)=>Icon(Icons.image_not_supported_rounded),
                                             errorListener: (error){
                                               debugPrint('ERROR IN CACHED NETWORK IMAGE : $error');
                                             },
                                           ),
                                           Text(
                                             '${snapshot.data!.current.temperature.toString()} °C',
                                             style: Theme.of(context)
                                                 .textTheme
                                                 .titleLarge,
                                           ),
                                         ],
                                       ),
                                       Text(
                                         snapshot.data!.current.condition
                                             .weatherDescription,
                                         softWrap: true,
                                         maxLines: 2,
                                         overflow: TextOverflow.ellipsis,
                                         style: Theme.of(context)
                                             .textTheme
                                             .titleSmall?.copyWith(
                                           color: Colors.grey.shade500,
                                         ),
                                       ),
                                       Row(
                                         mainAxisAlignment:
                                         MainAxisAlignment.center,
                                         children: [
                                           Icon(Icons
                                               .location_on_rounded, color: Colors.red.shade600,),
                                           SizedBox(width: 20),
                                           Text(
                                             '${snapshot.data!.location.country}-${snapshot.data!.location.administrativeArea ?? snapshot.data!.location.cityName }',
                                             maxLines: 1,
                                             overflow:
                                             TextOverflow.clip,
                                           ),
                                         ],
                                       ),
                                     ],
                                   )),
                               Expanded(
                                   child: Wrap(
                                     children: [
                                       Container(
                                         width: MediaQuery.of(context)
                                             .size
                                             .width /
                                             2,
                                         child: WeatherDetailsCard(
                                           weatherDetailMetricName:
                                           'Wind Speed',
                                           weatherDetailValue:
                                           '${snapshot.data!.current.windSpeed} KPH',
                                           icon: Icon(
                                             WeatherIcons.wind,
                                             color: Colors.blue,
                                           ),
                                         ),
                                       ),
                                       Container(
                                         width: MediaQuery.of(context)
                                             .size
                                             .width /
                                             2,
                                         child: WeatherDetailsCard(
                                           weatherDetailMetricName:
                                           'Pressure',
                                           weatherDetailValue:
                                           '${snapshot.data!.current.pressure} %',
                                           icon: Icon(Icons.compress_rounded , color: Colors.deepOrange,),
                                         ),
                                       ),
                                       Container(
                                         width: MediaQuery.of(context)
                                             .size
                                             .width /
                                             2,
                                         child: WeatherDetailsCard(
                                           weatherDetailMetricName:
                                           'Feels Like',
                                           weatherDetailValue:
                                           '${snapshot.data!.current.feelsLike} °C ',
                                           icon: Icon(WeatherIcons.temperatire, color: Colors.red),
                                         ),
                                       ),
                                       Container(
                                         width: MediaQuery.of(context)
                                             .size
                                             .width /
                                             2,
                                         child: WeatherDetailsCard(
                                           weatherDetailMetricName:
                                           'Clouds',
                                           weatherDetailValue:
                                           '${snapshot.data!.current.clouds} %',
                                           icon: Icon(WeatherIcons.cloud, color: Colors.cyan.shade200,) ,
                                         ),
                                       ),
                                       Container(
                                         width: MediaQuery.of(context)
                                             .size
                                             .width /
                                             2,
                                         child: WeatherDetailsCard(
                                           weatherDetailMetricName:
                                           'Humidity',
                                           weatherDetailValue:
                                           '${snapshot.data!.current.humidity} %',
                                           icon: Icon(Icons.water_drop_outlined, color: Colors.blue.shade600)
                                           ,
                                         ),
                                       ),
                                       Container(
                                         width: MediaQuery.of(context)
                                             .size
                                             .width /
                                             2,
                                         child: WeatherDetailsCard(
                                           weatherDetailMetricName:
                                           'Vision',
                                           weatherDetailValue:
                                           '${snapshot.data!.current.visionPerKiloMeter} KM',
                                           icon: Icon(Icons.visibility_outlined, color: Colors.brown.shade300) ,
                                         ),
                                       ),
                                     ],
                                   )),
                             ],
                           );
                         }
                         else if (snapshot.hasError) {
                           // return screen that indicate an error
                           return Center(child: Text('Error , ${snapshot.error} ... ${snapshot.stackTrace}'));
                         }
                         else{
                           // loading animation
                           return const CurrentWeatherTopPartLoading();

                         }
                         // no loading here (responsibility of conditional builder)
                       },
                     ),
                   ),
                   Container(
                     child: FutureBuilder(
                       future: cubit.getTodayWeatherForecasts(),
                       builder: (context, snapshot) {
                         if (snapshot.hasData && state is! HomeScreenLoadingState) {
                           var tempList = [
                             for (int i = 0; i < 24; i++)
                               RepresentableData(
                                   value: snapshot
                                       .data!.hoursOverDay[i].temp,
                                   category:i)
                           ];

                           return Column(
                             children: [
                               SmoothAreaChart(
                                 chartTitle: 'Today Temperature',
                                 xAxisTitle: 'Hours',
                                 yAxisTitle: 'C',
                                 dataSource: tempList,
                               ),
                               Container(
                                   height: MediaQuery.of(context).size.width / 4,
                                   width: double.infinity,
                                   child: CarouselSlider(
                                     items: [
                                       WeatherDetailsCard(
                                         weatherDetailMetricName:
                                         'Max Temp',
                                         centerIconAndTitle: true,
                                         icon: Icon(WeatherIcons
                                             .temperatire,
                                           color: Colors.red,
                                         ),
                                         weatherDetailValue: snapshot
                                             .data!.day.maxTemp,
                                       ),
                                       WeatherDetailsCard(
                                         weatherDetailMetricName:
                                         'Min Temp',
                                         icon: Icon(WeatherIcons
                                             .temperatire,
                                           color: Colors.red,
                                         ),
                                         centerIconAndTitle: true,
                                         weatherDetailValue: snapshot
                                             .data!.day.minTemp,
                                       ),
                                       WeatherDetailsCard(
                                         weatherDetailMetricName:
                                         'Rain Chance',
                                         icon:Icon(WeatherIcons.rain, color: Colors.lightBlueAccent,) ,
                                         centerIconAndTitle: true,
                                         weatherDetailValue: snapshot
                                             .data!.day.rainChance,
                                       ),
                                       WeatherDetailsCard(
                                         weatherDetailMetricName:
                                         'Snow Chance',
                                         icon:Icon(WeatherIcons.snow, color: Colors.white,) ,
                                         centerIconAndTitle: true,
                                         weatherDetailValue: snapshot
                                             .data!.day.snowChance,
                                       ),
                                       WeatherDetailsCard(
                                         weatherDetailMetricName:
                                         'Sun Rise',
                                         icon: Icon(WeatherIcons.sun, color: Colors.amber,),
                                         centerIconAndTitle: true,
                                         weatherDetailValue: snapshot
                                             .data!
                                             .astronomy
                                             .sunRise,
                                       ),
                                       WeatherDetailsCard(
                                         weatherDetailMetricName:
                                         'Sun Set',
                                         icon: Icon(WeatherIcons.sun_filled, color: Colors.deepOrange,),
                                         centerIconAndTitle: true,
                                         weatherDetailValue: snapshot
                                             .data!
                                             .astronomy
                                             .moonSet,
                                       ),
                                       WeatherDetailsCard(
                                         weatherDetailMetricName:
                                         'Moon Rise',
                                         icon: Icon(WeatherIcons.moon, color: Colors.grey.shade400,),
                                         centerIconAndTitle: true,
                                         weatherDetailValue: snapshot
                                             .data!
                                             .astronomy
                                             .moonRise,
                                       ),
                                       WeatherDetailsCard(
                                         weatherDetailMetricName:
                                         'Moon Set',
                                         icon: Icon(WeatherIcons.moon_inv, color: Colors.black,),
                                         centerIconAndTitle: true,
                                         weatherDetailValue: snapshot
                                             .data!
                                             .astronomy
                                             .moonSet,
                                       ),
                                     ],
                                     options: CarouselOptions(
                                       initialPage: 0,
                                       autoPlay: true,
                                       autoPlayAnimationDuration: Duration(seconds: 1),
                                       autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                                       enableInfiniteScroll: true,
                                       pauseAutoPlayOnTouch: true,
                                       enlargeCenterPage: true,
                                       scrollDirection: Axis.horizontal,
                                       pauseAutoPlayOnManualNavigate: true,
                                       enlargeFactor: 0.30,
                                       viewportFraction: .75,
                                     ),
                                   )
                               ),
                             ],
                           );
                         }
                         else if (snapshot.hasError) {
                           // return error screen
                           return Center(child: Text('Error getting forecasts , ${snapshot.error} ... ${snapshot.stackTrace}'));
                         }
                        // return AnimatedLoadingContainer(width: double.infinity, height:  MediaQuery.of(context).size.height/3);
                       return const CurrentWeatherBottomPartLoading();
                       },
                     ),
                   ),
                 ],
               ),
             ),
           );
      },

    );
  }
}
