import 'package:flutter/material.dart';
import 'package:weathy/core/utils/components/animated_loading_container.dart';

class SportsLoading extends StatelessWidget {
  const SportsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: AnimatedLoadingContainer(),
          ),
          Expanded(
            child: AnimatedLoadingContainer(),
          )
        ],
      ),
    );
  }
}
