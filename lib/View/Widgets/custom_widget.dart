
import 'package:flutter/material.dart';

import '../Model/Style.dart';

class CustomWidget{

  static Future<void> circularProgressIndicator(BuildContext context)async{
    await showDialog(context: context, builder: (context){

      return Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            color: Style.defaultHeadingColor,
            backgroundColor: Colors.white,
          ),
        ),
      );

    });
  }
}