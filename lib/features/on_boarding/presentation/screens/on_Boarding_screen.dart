import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/check_connectivity.dart';
import '../../../../core/utils/components/gradient_text.dart';
import '../../../../core/utils/components/into_text.dart';
import '../../../../core/utils/components/page_indicator.dart';
import '../../../maps_screen/maps_screen.dart';

class OnBoardingScreen extends StatelessWidget {

  static const route = 'onBoarding';

  final controller = PageController(
    initialPage: 0,
  );
  int pageIndex = 0;

  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/core/assets/appIcon.gif',
                    width: 100,
                    height: 100,
                  ),
                  GradientText(
                    text: 'Weathy',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 35,
                      overflow: TextOverflow.ellipsis,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.lightBlueAccent,
                        Colors.blue,
                        Colors.orange,
                        Colors.red,
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  color: Color(0xffebeef2),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: MySmoothPageIndicator(
                          count: 4,
                          controller: controller,
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PageView(
                          controller: controller,
                          children: [
                            IntroductoryText(
                                title: 'Today Weather',
                                subTitle:
                                    'Presents all the info related to the weather status of Current Day.'),
                            IntroductoryText(
                                title: 'Forecasts',
                                subTitle:
                                    'Weather status of the coming ten days.'),
                            IntroductoryText(
                                title: 'Sports',
                                subTitle:
                                    'Specially football matches that will be played in the next days'),

                            Column(
                              children: [
                                IntroductoryText(
                                    title: 'Your Location',
                                    subTitle:
                                        'You can either provide you location by yourself by picking it from the map, or you can let the app to detect your location.'),

                                FutureBuilder(
                                    future:checkConnectivity(),
                                    builder: (context,snapshot){
                                      if(snapshot.hasData){
                                        return (snapshot.data!)?Padding(
                                          padding: const EdgeInsets.only(top: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              FilledButton.icon(
                                                onPressed: () {
                                                 // SharedPrefWriter.writeData(keyName: AppConstants.isNewUser, data: false);

                                                },
                                                icon: Icon(Icons.location_on_rounded),
                                                label: Text('Let App'),
                                              ),
                                              FilledButton.icon(
                                                onPressed: () {

                                                  Navigator.of(context).pushNamed(MapsScreen.route,);

                                                },
                                                icon: Icon(Icons.map),
                                                label: Text('Pick Map'),
                                              ),
                                            ],
                                          ),
                                        )
                                      :
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                            'You are not connected to Internet!',
                                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      );
                                      }
                                      else if(snapshot.hasError){
                                        return Text('Something went wrong');
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Checking Your Connection...',
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      );

                                    },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FloatingActionButton(
                              heroTag: 'btn 2',
                              onPressed: () {
                                animateToPreviousPage();
                                },
                              child: Icon(Icons.arrow_back_ios_new_rounded),
                            ),
                            FloatingActionButton(
                              heroTag: 'btn 3',
                              onPressed: () {
                                animateToNextPage();
                              },
                              child: Icon(Icons.arrow_forward_ios_rounded),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            )),
          ],
        ),
      ),
    ));
  }

  void animateToNextPage(){
    pageIndex = controller.page!.toInt();
    if (pageIndex == 3) {
      pageIndex = 0;
      controller.animateToPage(pageIndex,
          duration: Duration(microseconds: 300),
          curve: Curves.easeIn);
    }
    else{
      controller.animateToPage(++pageIndex,
          duration: Duration(microseconds: 300),
          curve: Curves.easeIn);
    }
  }
  void animateToPreviousPage(){
    pageIndex = controller.page!.toInt();
    if (pageIndex == 0) {
      pageIndex = 3;
      controller.animateToPage(pageIndex,
          duration: Duration(microseconds: 300),
          curve: Curves.easeIn);
    }
    else{
      controller.animateToPage(--pageIndex,
          duration: Duration(microseconds: 300),
          curve: Curves.easeIn);
    }
  }
}
