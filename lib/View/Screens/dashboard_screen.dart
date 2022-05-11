import 'dart:ui';

import 'package:bunyaad/Controller/login_controller.dart';
import 'package:bunyaad/Model/chat_group.dart';
import 'package:bunyaad/Model/variables.dart';
import 'package:bunyaad/View/Model/Style.dart';
import 'package:bunyaad/View/Screens/login_screen.dart';
import 'package:bunyaad/View/SubScreens/buyer_request.dart';
import 'package:bunyaad/View/SubScreens/order_detail.dart';
import 'package:bunyaad/View/SubScreens/seller_account_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../SubScreens/home_screen.dart';
import '../SubScreens/settings.dart' as S;
import '../Widgets/Search.dart';
import 'chat_groups.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  FocusNode focusNode = FocusNode();
  bool isLiked = true;
  String searchText = "";
  bool isSearched = false;




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
                    if( searchText != "") {
                      focusNode.unfocus();
                      setState(() {
                        isSearched =true;
                      });
                    }
                  },
                  onChanged: (value){

                    if(value.isEmpty){
                      isSearched = false;
                      searchText = "";
                      focusNode.unfocus();
                      setState(() {

                      });

                    }
                    else{

                      searchText = value.toString();
                    }

              }, focusNode: focusNode),
            ),
            const SizedBox(height: 40,),
            isSearched?Container(
                height: 400,
                child: searchSellerTile(searchText)):cardsFunction(),
            const SizedBox(height: 48,),

          ],
        ),
      ),
    );
  }

  Widget cardsFunction(){
    return Column(
      children: [
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
            const SizedBox(width: 24.0,),
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
        const SizedBox(height: 32,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCard(icon: Icons.settings,heading: "Settings",onPress: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return
                      const S.Settings();
                  },
                ),
              );
            }),
            const SizedBox(width: 24.0,),
            buildCard(icon: Icons.chat_bubble_outline,heading: "Chat",onPress: () async {
              print("hello");
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return
                      ChatGroups();
                  },
                ),
              );
            }),
          ],
        ),
        const SizedBox(height: 24,),
        buildCard(icon: Icons.chat_bubble_outline,heading: "My Orders",onPress: () async {
          print("my orders");
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return
                  OrderDetail();
              },
            ),
          );
        }),
      ],
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
            const SizedBox(height: 8.0,),
            Text(heading,style: TextStyle(color: Colors.white,fontSize: 20),)
          ],
        ),
      ),
    );
  }


  Widget searchSellerTile(String searchName) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("seller").where("nameS",arrayContains: searchName.toLowerCase())
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                // width: 250,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)
                ),
                child:ListTile(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return
                            SellerAccountView (sellerName : document["name"], address : document["address"], businessName : document["businessName"], city : document["city"], phoneNumber : document["phoneNumber"], imageLink : document["imageLink"], sellerId : document["id"],);
                        },
                      ),
                    );
                  },
                  title: Text(document["name"],style: TextStyle(color: Colors.white,fontSize: 18)),
                ),
              );
            }).toList(),
          );
        });
  }






}
