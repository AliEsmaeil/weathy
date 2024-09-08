import 'package:flutter/material.dart';
import 'package:weathy/core/utils/components/animated_loading_container.dart';

class CurrentWeatherBottomPartLoading extends StatelessWidget {
  const CurrentWeatherBottomPartLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*(1/3),
            child: AnimatedLoadingContainer()
        ),
        Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width*(1/4),
            child: AnimatedLoadingContainer()
        ),

      ],
    );
  }
}
