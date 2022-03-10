
import 'package:bunyaad/View/Screens/seller_signup.dart';
import 'package:bunyaad/View/Screens/seller_signupsimple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/Style.dart';
import 'login_screen.dart';


class CreateSellerAccount extends StatefulWidget {
  const CreateSellerAccount({Key? key}) : super(key: key);

  @override
  _CreateSellerAccountState createState() => _CreateSellerAccountState();
}

class _CreateSellerAccountState extends State<CreateSellerAccount> {

  bool showProducts=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundColor(),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
 //       iconTheme: IconThemeData.fallback(),

        title: Text(
          "Bunyaad",
          style: Style.heading(),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.black87,
                    fontStyle: FontStyle.italic,
                    fontSize: 18),
              )),

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
              padding: const EdgeInsets.only(left: 24, top: 24, bottom: 20),
              child: Text("Choose Category", style: TextStyle(fontSize: 28,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: Style.primaryButtonStyle(buttonColor: Colors.grey),
                  onPressed: ()async {

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SellerSignupSimple();
                        },
                      ),
                    );
                  },
                  child: Text("Products"),
                ),
                SizedBox(width: 24.0,),
                ElevatedButton(
                  style: Style.primaryButtonStyle(buttonColor: showProducts?Style.defaultHeadingColor:Colors.grey),
                  onPressed: ()async {
                    showProducts = !showProducts;
                    setState(() {

                    });
                   /* await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const CreateSellerAccount2();
                        },
                      ),
                    );*/
                  },
                  child: Text("Services"),
                ),
              ],
            ),

            SizedBox(height: 32,),
            !showProducts?SizedBox.shrink():buildProducts(context),

          ],
        )
      ),
    );
  }



  Widget buildProducts(BuildContext context){
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 24, top: 24, bottom: 20),
          child: Text("Choose Service", style: TextStyle(fontSize: 28,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: 12,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: Style.primaryButtonStyle(buttonColor: Colors.grey),
              onPressed: ()async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SellerSignupSimple();
                    },
                  ),
                );
              },
              child: Text("Builder"),
            ),
            SizedBox(width: 16.0,),
            ElevatedButton(
              style: Style.primaryButtonStyle(buttonColor: Colors.grey),
              onPressed: ()async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SellerSignupSimple();
                    },
                  ),
                );
              },
              child: Text("Contractor"),
            ),
            SizedBox(width: 16.0,),
            ElevatedButton(
              style: Style.primaryButtonStyle(buttonColor: Colors.grey),
              onPressed: ()async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SellerSignup();
                    },
                  ),
                );
              },
              child: Text("Architect"),
            ),
          ],
        ),
      ],
    );

  }
}
