import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedLoadingContainer extends StatefulWidget {


  const AnimatedLoadingContainer({super.key,});

  @override
  State<AnimatedLoadingContainer> createState() => _AnimatedLoadingContainerState();
}

class _AnimatedLoadingContainerState extends State<AnimatedLoadingContainer> {
  double opacity = .25;

  @override
  void initState(){
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(mounted){
        setState(() {
          opacity = opacity == 0.15 ? 1 : 0.15 ;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
   return SizedBox.expand(
       child: AnimatedOpacity(
       duration: Duration(seconds: 1),
       opacity: opacity.toDouble(),
       child: Container(
         margin: EdgeInsets.all(8),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(12),
             color:Theme.of(context).scaffoldBackgroundColor == Colors.white ?  Colors.grey.shade300 : Colors.grey.shade800,

         ),
        // width: widget.width,
        // height: widget.height,

       ),

     ),
   );
  }
}
