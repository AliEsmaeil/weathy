import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weathy/core/assets/icons/weather_icons_icons.dart';
import 'package:weathy/features/weather_screens/presentation/helpers/details_card.dart';

class DayWeatherCard extends StatelessWidget {
  final String date;
  final String dayName;
  final String weatherImageUrl;
  final String temperature;
  final String weatherDescription;
  final String windSpeed;
  final String humidity;
  final String feelsLike;
  final String rainChance;

  const DayWeatherCard(
      {
      super.key,
      required this.date,
      required this.dayName,
      required this.weatherImageUrl,
      required this.temperature,
      required this.weatherDescription,
      required this.windSpeed,
      required this.humidity,
      required this.feelsLike,
      required this.rainChance});


  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: Theme.of(context).brightness == Brightness.light? <Color>[
              Colors.white,
              Colors.grey.shade100,
              Colors.grey.shade300
            ] : <Color>[
              Colors.grey.shade600,
              Colors.grey.shade800,
              Colors.grey.shade900,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              date,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(
                color: Colors.grey,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dayName,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall,
              ),
              CachedNetworkImage(
                imageUrl:
                'https:$weatherImageUrl',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    Icon(Icons
                        .image_not_supported_rounded),
                errorListener: (error) {
                  debugPrint(
                      'ERROR IN CACHED NETWORK IMAGE (forecast tab) : $error');
                },
              ),
            ],
          ),
          Text(
            '$temperature °',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            weatherDescription,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(
              color: Colors.grey,
            ),
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context)
                      .size
                      .width /
                      3,
                  child: WeatherDetailsCard(
                    icon: Icon(WeatherIcons.wind,
                        color: Colors.blue),
                    weatherDetailMetricName:
                    'Wind Speed',
                    centerIconAndTitle: true,
                    weatherDetailValue:
                    '$windSpeed KPH',
                  ),
                ),
              ),
              Expanded(
                child: WeatherDetailsCard(
                  icon: Icon(Icons.water_drop_outlined,
                      color: Colors.blue.shade600),
                  weatherDetailMetricName: 'Humidity',
                  centerIconAndTitle: true,
                  weatherDetailValue:
                  '$humidity %',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context)
                      .size
                      .width /
                      3,
                  child: WeatherDetailsCard(
                    icon: Icon(
                      WeatherIcons.temperatire,
                      color: Colors.red,
                      size: 15,
                    ),
                    weatherDetailMetricName:
                    'Feels Like',
                    centerIconAndTitle: true,
                    weatherDetailValue:
                    '$feelsLike °',
                  ),
                ),
              ),
              Expanded(
                child: WeatherDetailsCard(
                  icon: Icon(WeatherIcons.rain,
                      color: Colors.blue.shade600),
                  weatherDetailMetricName:
                  'Rain Chance',
                  centerIconAndTitle: true,
                  weatherDetailValue:
                  '$rainChance %',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
