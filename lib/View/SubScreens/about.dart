import 'package:flutter/material.dart';

import '../Model/Style.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
                      "About",
                      style: TextStyle(
                          fontSize: 28,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n \nRegards,\nBunyaad Team",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      )
                  ),
                ]
            )
        )
    );
  }
}
