import 'package:flutter/material.dart';
import 'package:weathy/core/utils/components/animated_loading_container.dart';

class CurrentWeatherTopPartLoading extends StatelessWidget {
  const CurrentWeatherTopPartLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height:MediaQuery.of(context).size.height * (2 / 3),
      child: Column(
        children: [
          Expanded(
            child: AnimatedLoadingContainer(),
          ),
          Expanded(
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.width/5,
                    child: AnimatedLoadingContainer()
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.width/5,
                    child: AnimatedLoadingContainer()
                ),  SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.width/5,
                    child: AnimatedLoadingContainer()
                ),  SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.width/5,
                    child: AnimatedLoadingContainer()
                ),  SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.width/5,
                    child: AnimatedLoadingContainer()
                ),  SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.width/5,
                    child: AnimatedLoadingContainer()
                ),
              ],
            ),
          ),
        ],
      ),


    );
  }
}
