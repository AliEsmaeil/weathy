import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathy/core/utils/extensions/current_day_extension.dart';
import 'package:weathy/features/loading_animation/sports_loading.dart';

import '../controllers/current_weather_cubit/cubit.dart';
import '../controllers/current_weather_cubit/states.dart';

class SportsTab extends StatelessWidget {
  const SportsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeScreenCubit.getCubit(context);

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      cubit.changeThemeMode();
                    },
                    icon: Icon(Icons.light_mode_rounded)),
              ],
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.width/ 4,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1.2,
                title: Text('Coming Matches', style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.grey,
                ),),
              ),
            ),

            SliverList.list(
                children: [
              FutureBuilder(
                future: cubit.getComingFootballMatches(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && state is! HomeScreenLoadingState) {
                    if (snapshot.data!.matches.isNotEmpty) {
                      return Column(children: [
                        for (int index = 0;
                            index < snapshot.data!.matches.length;
                            index++)
                          // sports card is not reused in any where else. just here
                          Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width * 0.75,
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
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(snapshot
                                            .data!.matches[index].country),
                                        Text(
                                          snapshot
                                              .data!.matches[index].tournament,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        Text(
                                          snapshot.data!.matches[index].match,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: Colors.grey,
                                                decorationStyle:
                                                    TextDecorationStyle.solid,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 0,
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .access_time_filled_rounded,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                ),
                                                Text(
                                                  (DateTime.parse(snapshot.data!
                                                          .matches[index].start)
                                                      .getDayName()),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                Text(
                                                  snapshot.data!.matches[index]
                                                      .start,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: Colors.grey,
                                                      ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        VerticalDivider(),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.stadium,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                              ),
                                              Text.rich(TextSpan(
                                                  text: snapshot.data!
                                                      .matches[index].stadium,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                  children: [
                                                    TextSpan(
                                                      text: ' stadium',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                    )
                                                  ])),
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  )
                                ],
                              ))
                      ]);
                    }
                    else {
                      return Center(
                          child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.sports_volleyball,
                                size: 120, color: Colors.orange),
                            Text('No Coming Matches',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                  color: Colors.grey,
                                ))
                          ],
                        ),
                      ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            'matches Error , ${snapshot.error} , ${snapshot.stackTrace}'));
                  } else {
                    return const SportsLoading();
                  }
                },
              ),
            ]),
          ],
        );
      },
    );
  }
}
