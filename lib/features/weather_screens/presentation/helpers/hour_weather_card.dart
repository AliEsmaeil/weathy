import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HourWeatherCard extends StatelessWidget {

  final int hour;
  final String imageUrl;
  final String temperature;

  const HourWeatherCard({ required this.hour,required this.imageUrl,required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width / 5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors:  Theme.of(context).brightness == Brightness.light? <Color>[
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
        child: Column(children: [
          CachedNetworkImage(
            imageUrl:
            'https:$imageUrl',
            errorWidget: (context, url, error) =>
                Icon(Icons
                    .image_not_supported_rounded),
            fit: BoxFit.cover,
            errorListener: (error) {
              debugPrint(
                  'ERROR IN CACHED NETWORK IMAGE (forecast tab) : $error');
            },
          ),
          Text(
            '$temperature °',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text('${hour == 0 ? '12 ' : hour > 12? (hour-12).toString() : hour} ${hour < 12 ? 'AM' : 'PM'}'),
        ]
        )
    );
  }
}
