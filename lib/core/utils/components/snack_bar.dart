
import 'package:flutter/material.dart';
import 'package:weathy/core/utils/inner_models/internet_connection_state.dart';

SnackBar getSnackBar({required String message, required  InternetConnectionState connectionState }){
  return SnackBar(
    content: Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 50,
      child: Text(message, style: TextStyle(color: Colors.white),),
    ),
    backgroundColor: connectionState == InternetConnectionState.online? Colors.green.shade500 : Colors.grey.shade500,
    duration: Duration(seconds: 3),
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.symmetric(horizontal: 8),
  );
}
