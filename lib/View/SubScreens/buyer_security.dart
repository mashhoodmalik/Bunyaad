import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../Model/variables.dart';
import '../Model/Style.dart';
import '../Widgets/custom_widget.dart';

class BuyerSecurity extends StatefulWidget {
  const BuyerSecurity({Key? key}) : super(key: key);

  @override
  _BuyerSecurityState createState() => _BuyerSecurityState();
}

class _BuyerSecurityState extends State<BuyerSecurity> {
  TextEditingController emailController = TextEditingController(text:
  Variables.isSeller ? Variables.seller!.email : Variables.buyer!.email);
  final auth = FirebaseAuth.instance;
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
                  "Security",
                  style: TextStyle(
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 32,),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 36),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff192b8d),
                      fixedSize: Size(150, 30),),
                    onPressed: () async {
                      auth.sendPasswordResetEmail(email: emailController.text);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BuyerSecurity()));
                      Fluttertoast.showToast(msg: "A Mail has been sent to your email address");
                    },
                    child: Text("Change Password"),
                  )

              ),

            ],
          ),
        ),
    );

  }
}

