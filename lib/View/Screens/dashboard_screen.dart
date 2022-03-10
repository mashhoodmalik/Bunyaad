import 'dart:ui';

import 'package:bunyaad/Controller/login_controller.dart';
import 'package:bunyaad/View/Model/Style.dart';
import 'package:bunyaad/View/Screens/login_screen.dart';
import 'package:bunyaad/View/SubScreens/buyer_request.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../SubScreens/home_screen.dart';
import '../SubScreens/settings.dart';
import '../Widgets/Search.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

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
        child: ListView(
          children: [
            SizedBox(height: 32,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SearchBar(
                  searchFunction: (){

                  },
                  onChanged: (value){

              }, focusNode: focusNode),
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCard(icon: Icons.home,heading: "Home",onPress: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return
                          const HomeScreen();
                      },
                    ),
                  );
                }),
                SizedBox(width: 24.0,),
                buildCard(icon: Icons.person_add_alt,heading: "Buyer Request",onPress: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return
                          const BuyerRequest();
                      },
                    ),
                  );
                }),
              ],
            ),
            SizedBox(height: 32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCard(icon: Icons.settings,heading: "Settings",onPress: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return
                          const Settings();
                      },
                    ),
                  );
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

  Widget buildDescriptionCard(BuildContext context){

    return Container(
      margin: EdgeInsets.symmetric(horizontal:16),
      decoration: BoxDecoration(
        border: Border.all(),
        // borderRadius: BorderRadius.circular(25),
        // color:  Style.defaultHeadingColor,
      ),
      height: 200,
      width: MediaQuery.of(context).size.width*0.9,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 32,vertical: 16),
                  color: Colors.black87,
                  height: 100,
                ),
              ),
              Expanded(
                  flex:1,child: GestureDetector(
                  onTap: (){
                    isLiked = !isLiked;
                    setState(() {

                    });
                  },
                  child: isLiked==true?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border))),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blue,
                    width: 32,
                    height: 32,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      Text("Item Name",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 20),),
                      SizedBox(height: 8,),
                      Text("Short Description",style: TextStyle(color: Colors.black87,fontStyle: FontStyle.italic,fontSize: 16),)
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text("Price"),
                )

              ],
            ),
          )
        ],
      ),
    );
  }

}
