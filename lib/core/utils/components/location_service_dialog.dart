import 'package:flutter/material.dart';

void showAlertDialog({required BuildContext context, required String message , String title = 'No Internet'}) {
  showAdaptiveDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog.adaptive(
        title:  Text(title , textAlign: TextAlign.center,),

        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      );
    },
  );
}
