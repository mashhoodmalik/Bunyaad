import 'package:bunyaad/View/SubScreens/seller_account_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Controller/login_controller.dart';
import '../Model/Style.dart';
import '../SubScreens/seller_buyerrequest.dart';
import 'login_screen.dart';

class SellerDashboard extends StatefulWidget {
  const SellerDashboard({Key? key}) : super(key: key);

  @override
  _SellerDashboardState createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  FocusNode focusNode = FocusNode();
  bool isLiked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundColor(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text("Bunyaad", style: Style.heading(),),
        actions: [
          ClipOval(
            child: IconButton(
                onPressed: ()async{
                  LoginController.signout();
                  Fluttertoast.showToast(msg: "Logged Out");
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return
                          const LoginScreen();
                      },
                    ),
                  );

                },
                icon: Icon(Icons.login,color:Colors.black87,size: 32,)
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
                "Dashboard",
                style: TextStyle(
                    fontSize: 28,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 80,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCard(icon: Icons.home,heading: "Home",onPress: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return
                          const SellerAccountSettings();
                      },
                    ),
                  );
                }),
                SizedBox(width: 24.0,),
                buildCard(icon: Icons.person,heading: "Buyer Request",onPress: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return
                          const SellerBuyerRequest();
                      },
                    ),
                  );
                }
                ),
              ],
            ),),
            SizedBox(height: 32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCard(icon: Icons.description,heading: "My Gigs",onPress: (){
                  print("My Gigs");
                }),
                SizedBox(width: 24.0,),
                buildCard(icon: Icons.chat_bubble_outline,heading: "Chat",onPress: (){
                  print("Chat");
                }),
              ],
            ),
            SizedBox(height: 48,),
            /*Container(
              height: 600,
              child: ListView.separated(
                  itemCount: 5,
                  itemBuilder: (BuildContext context,index){
                return buildDescriptionCard(context);
              }, separatorBuilder: (BuildContext context, int index) {
                    return Container(height: 8,);
              },),
            )*/
          ],
        ),
      ),
    );
  }

  Widget buildCard({required IconData icon,required String heading,Function()? onPress}){
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color:  Style.defaultHeadingColor,
        ),
        height: 120,
        width: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon,color: Colors.white,size: 50,),
            SizedBox(height: 8.0,),
            Text(heading,style: TextStyle(color: Colors.white,fontSize: 20),)
          ],
        ),
      ),
    );
  }

}