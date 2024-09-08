import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathy/core/utils/check_connectivity.dart';
import 'package:weathy/core/utils/components/location_service_dialog.dart';
import 'package:weathy/features/weather_screens/presentation/controllers/current_weather_cubit/cubit.dart';

import '../../../maps_screen/maps_screen.dart';
import '../controllers/current_weather_cubit/states.dart';

class CitySearchBar extends StatelessWidget {
  final SearchController searchController = SearchController();
  final TextEditingController editingController = TextEditingController();
  final FocusNode node = FocusNode();

  CitySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
      var cubit = HomeScreenCubit.getCubit(context);
      return Container(
        width: double.infinity,
        height: 60,
        padding: EdgeInsets.all(10),
        child: SearchAnchor(
          searchController: searchController,
            isFullScreen: false,
            viewLeading: IconButton(icon: Icon(Icons.arrow_back) , onPressed: (){
              Navigator.of(context).pop();
              node.unfocus();
            },),
            dividerColor: Colors.grey.shade300,
            textCapitalization: TextCapitalization.words,
            viewSurfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
            viewSide: BorderSide(color: Colors.grey.shade300, width: 1),
            viewBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            viewOnSubmitted: (city) { // close the search view
              print('.................SEARCH VIEW SUBMITTED....................');
              searchController.closeView(city);
              node.unfocus();
              cubit.checkIfApiKnowsCity(city: city);
            },
            viewOnChanged: (str) {
              searchController.text = str;
              editingController.text = str;

              print('.................SEARCH VIEW CHANGED....................');
            },
            builder: (context, controller) {
              return SearchBar(
                focusNode: node,
                  controller: editingController,
                  onTap: () {
                  if(cubit.isConnected)
                  {
                    controller.openView();
                  }
                  else{
                    node.unfocus();
                    showAlertDialog(context: context, message: "You are offline");
                  }
                  },// search controller associated with SearchAnchor
                  hintText: 'Search City or Country',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.go,
                  leading: Icon(
                    Icons.search_rounded,
                  ),

                  trailing: [
                    IconButton(
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.red.shade600,
                      ),
                      onPressed: () async {
                        if (cubit.isConnected) {
                          cubit.changeLocationByGeoLocator();
                        } else {
                          showAlertDialog(
                              context: context,
                              message:
                                  'You are offline, we can\'t detect your location while you are offline');
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.map,
                        color: Colors.green.shade500,
                      ),
                      onPressed: () async {
                        if (cubit.isConnected) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MapsScreen(),
                            ),
                          );
                        } else {
                          showAlertDialog(
                              context: context,
                              message:
                                  'You are offline, you can\'t open maps while you are offline');
                        }
                      },
                    ),
                  ]
              );
            },
            suggestionsBuilder: (context, controller) async{
              // you should represent city search history (should be stored in db).
              var list =  await cubit.getSearchedCities();
              return list.map((e) {
                return InkWell(
                  onTap: (){},
                  overlayColor: MaterialStatePropertyAll(Colors.grey.shade200),
                  child: ListTile(
                    title: Text(e),
                    leading: Icon(Icons.history, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8 ,),
                    onTap: (){
                      controller.text = e;
                      if(controller.isOpen){
                        controller.closeView(e);
                      }
                      node.unfocus();
                      cubit.checkIfApiKnowsCity(city: e);
                    },
                  ),
                );
              });
            }),
      );
    });
  }
}
