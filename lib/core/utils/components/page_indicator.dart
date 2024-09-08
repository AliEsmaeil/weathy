import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MySmoothPageIndicator extends StatelessWidget {
  PageController controller;
  int count;
  MySmoothPageIndicator({super.key , required this.count, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: 4,
      axisDirection: Axis.horizontal,
      effect: WormEffect(
        activeDotColor: Colors.blue.shade600,
        dotColor: Colors.grey,
        dotHeight: 8,
        dotWidth: 8,
        spacing: 12,
      ),
    );
  }
}
