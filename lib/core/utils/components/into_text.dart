import 'package:flutter/material.dart';

class IntroductoryText extends StatelessWidget {

  final String title;
  final String subTitle;

  IntroductoryText({super.key, required this.title , required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.grey.shade500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
        )
      ],
    );
  }
}
