import 'package:flutter/material.dart';

import '../Model/Style.dart';
import '../Widgets/custom_widget.dart';

class Support extends StatefulWidget {
  const Support({Key? key}) : super(key: key);

  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.backgroundColor(),
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: (){Navigator.pop(context);},
              icon: Icon(Icons.arrow_back_ios, color: Colors.black,)
          ),
          title: Text("Bunyaad", style: Style.heading(),),
          actions: [
            ClipOval(
              child: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.switch_account_rounded,color:Colors.black87,size: 32,)
              ),
            )
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(vertical: 56),
          child: ListView(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    "Support",
                    style: TextStyle(
                        fontSize: 28,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      decoration: Style.fieldsDecoration(hintText: "Enter Name"),
                    )),
                SizedBox(height: 16),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      decoration: Style.fieldsDecoration(hintText: "Enter Email"),
                    )),
                SizedBox(height: 40,),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: Text("Describe your inquiry",
                      style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),)),
                SizedBox(height: 16,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  height: 200,
                  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                      border: Border.all()
                  ),
                  child: TextFormField(
                    maxLines: 11,
                    maxLength: 500,
                    controller: description,
                  ),
                ),
                SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: Style.primaryButtonStyle(),
                        onPressed: ()async{
                          CustomWidget.circularProgressIndicator(context);
                        },
                        child: Text("Send")),
                  ],
                )
              ]
          ),
        ));
  }
}
