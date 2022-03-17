import 'package:bunyaad/Model/variables.dart';
import 'package:bunyaad/View/SubScreens/conversation_screen.dart';
import 'package:bunyaad/View/Widgets/custom_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/Style.dart';

class ChatGroups extends StatefulWidget {

  @override
  _ChatGroupsState createState() => _ChatGroupsState();
}

class _ChatGroupsState extends State<ChatGroups> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "Bunyaad",
          style: Style.heading(),
        ),
        actions: [
          ClipOval(
            child: IconButton(
                onPressed: () async {
                  /*LoginController.signout();
                  Fluttertoast.showToast(msg: "Logged Out");
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );*/
                },
                icon: Icon(
                  Icons.login,
                  color: Colors.black87,
                  size: 32,
                )),
          )
        ],
      ),
    body:SafeArea(
      child: Column(
        children: [
          SizedBox(height: 30),
          Expanded(child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )
            ),
            child: Variables.isSeller?chatRecordsSeller():chatRecordsBuyer(),
          ),
          ),
          // newMessage()
        ],
      ),
    )
    );
  }



  Widget chatRecordsBuyer(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("ChatGroup").where("buyer",isEqualTo: Variables.buyer!.docId).snapshots(),//.doc(widget.chatRoomId).collection("Chats").orderBy("timeStamp",descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData){
            return const Center(
              child:CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document){
              // print("hello");
              return Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return
                            ConversationScreen(chatRoomId: document["chatRoomId"], userId: Variables.buyer!.docId);
                        },
                      ),
                    );
                  },
                  title: Text(document["sellerName"],style: TextStyle(color: Colors.white,fontSize: 18)),
                ),
              );

            }).toList(),
          );
        }
    );
  }

  Widget chatRecordsSeller(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("ChatGroup").where("seller",isEqualTo: Variables.seller!.docId).snapshots(),//.doc(widget.chatRoomId).collection("Chats").orderBy("timeStamp",descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData){
            return const Center(
              child:CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document){
              // print("hello");
              return Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return
                            ConversationScreen(chatRoomId: document["chatRoomId"], userId: Variables.seller!.docId);
                        },
                      ),
                    );
                  },
                  title: Text(document["buyer"],style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
              );

            }).toList(),
          );
        }
    );
  }
}
