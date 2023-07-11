import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertScreen extends StatelessWidget {
   
  const AlertScreen({Key? key}) : super(key: key);

  void displayDialogIOS(BuildContext context) {

    showCupertinoDialog(
      barrierDismissible: true,
      context: context, 
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Hi IOS'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Alert Content'),
              SizedBox(height: 10,),
              FlutterLogo(size: 100,)
            ]
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close')
            )
          ],
        );
      }
    );

  }

  void displayDialog(BuildContext context) {
    
    showDialog(
      barrierDismissible: true,
      context: context, 
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          title: const Text('Hi'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Alert Content'),
              SizedBox(height: 10,),
              FlutterLogo(size: 100,)
            ]
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close')
            )
          ],
        );
      }
    );

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
         child: ElevatedButton(
          onPressed: () => Platform.isAndroid ? displayDialog(context) : displayDialogIOS(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Text('Alert', style: TextStyle(fontSize: 15),),
          )
        )
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context)
      ),

    );
  }
}