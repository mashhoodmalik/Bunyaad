import 'package:bunyaad/View/SubScreens/about.dart';
import 'package:bunyaad/View/SubScreens/buyer_account_settings.dart';
import 'package:bunyaad/View/SubScreens/buyer_security.dart';
import 'package:bunyaad/View/SubScreens/support.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/Style.dart';
import '../Screens/create_seller_account.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
          title: Text(
            "Bunyaad",
            style: Style.heading(),
          ),
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
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  "Settings",
                  style: TextStyle(
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 48.0, top: 56.0),
                child: Column(
                    children: [
                      Row(
                        children: [
                        TextButton(     // <-- TextButton
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context){
                                  return const BuyerAccountSettings();
                                },
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text("Account",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black87,
                                  fontStyle: FontStyle.italic,
                                ),
                              ), // <-- Text
                              SizedBox(
                                width: 160,
                              ),
                              Icon( // <-- Icon
                                Icons.arrow_forward_ios,
                                color: Colors.black87,
                                size: 24.0,
                              ),

                            ],

                          ),
                        ),
                      ],
                      ),
                      SizedBox( height: 24,),
                      Row(
                        children: [
                          TextButton(     // <-- TextButton
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context){
                                    return const BuyerSecurity();
                                  },
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text("Security",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ), // <-- Text
                                SizedBox(
                                  width: 160,
                                ),
                                Icon( // <-- Icon
                                  Icons.arrow_forward_ios,
                                  color: Colors.black87,
                                  size: 24.0,
                                ),

                              ],

                            ),
                          ),
                        ],
                      ),
                      SizedBox( height: 24,),
                      Row(
                        children: [
                          TextButton(     // <-- TextButton
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context){
                                    return const Support();
                                  },
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text("Support",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ), // <-- Text
                                SizedBox(
                                  width: 160,
                                ),
                                Icon( // <-- Icon
                                  Icons.arrow_forward_ios,
                                  color: Colors.black87,
                                  size: 24.0,
                                ),

                              ],

                            ),
                          ),
                        ],
                      ),
                      SizedBox( height: 24,),
                      Row(
                        children: [
                          TextButton(     // <-- TextButton
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context){
                                    return const About();
                                  },
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text("About",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ), // <-- Text
                                SizedBox(
                                  width: 180,
                                ),
                                Icon( // <-- Icon
                                  Icons.arrow_forward_ios,
                                  color: Colors.black87,
                                  size: 24.0,
                                ),

                              ],

                            ),
                          ),
                        ],
                      ),
                    ]
                ),
              )
            ],
          ),
        )
    );
  }
}
