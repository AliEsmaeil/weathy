
import 'package:flutter/material.dart';

class ListWheel extends StatelessWidget {
  final List<Widget> children;
  final String? title;
  final Function(int)? onSelectedItemChanged;
  final ScrollController? controller;

  ListWheel(
      {required this.children,
      this.title,
      this.onSelectedItemChanged,
      this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.width / 3,
      child: Column(
        children: [
          Text(title ?? ''),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  decoration: BoxDecoration(
                    color:  Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                ListWheelScrollView(
                  physics: FixedExtentScrollPhysics(),
                  controller: controller,
                  onSelectedItemChanged: onSelectedItemChanged,
                  useMagnifier: true,
                  itemExtent: 40,
                  magnification: 1.1,
                  diameterRatio: .75,
                  overAndUnderCenterOpacity: .5,
                  children: [
                    for(var child in children)
                      Center(child : child),
                  ]
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
