import 'package:bunyaad/Controller/chat_controller.dart';
import 'package:bunyaad/Model/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Controller/login_controller.dart';
import '../Model/Style.dart';
import '../Screens/login_screen.dart';

class ConversationScreen extends StatefulWidget {
  String chatRoomId = "fZw5vmM5ecgP0lcFuXIj";
  String userId = "mC6NoDTCrgi4PSsfoQJx";
  // final String sellerId= "RjkHYF2O7uMz8ojYode1";
  ConversationScreen({required this.chatRoomId,required this.userId});

  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {


  TextEditingController message = new TextEditingController();
  FocusNode focusNode = new FocusNode();
  ScrollController scrollController = new ScrollController();
  Widget ChatMessageList(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("ChatGroup").doc(widget.chatRoomId).collection("Chats").orderBy("timeStamp",descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData){
            return Center(
              child:CircularProgressIndicator(),
            );
          }
          return ListView(
            controller: scrollController,
            children: snapshot.data!.docs.map((document){
              // print("hello");
              return
              displayMessage(document["sender"]==widget.userId, document["message"]);

            }).toList(),
          );
        }
    );
  }

  Widget displayMessage(bool isMe,String message){
    return Row(
      mainAxisAlignment: isMe?  MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          margin:  EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isMe?Style.defaultHeadingColor:Colors.grey,
            borderRadius: isMe
                ? BorderRadius.only(
              topRight: Radius.circular(15),
                topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)
            ):BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),bottomRight: Radius.circular(15)
            )
          ),
          child: Column(
            crossAxisAlignment: isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
            children: [
              Text(message,style: TextStyle(color: Colors.white))
            ],
          ),
        )
      ],
    );
  }


  Future<void> sendMessage()async{
    ChatMessage chatMessage = new ChatMessage();
    chatMessage.populateBuyer(chatRoomId: widget.chatRoomId,message: message.text.toString(),sender: widget.userId);
    await ChatController.sendConversationMessage(widget.chatRoomId, chatMessage).whenComplete((){
    message.clear();
    focusNode.unfocus();
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  LoginController.signout();
                  Fluttertoast.showToast(msg: "Logged Out");
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                },
                icon: Icon(
                  Icons.login,
                  color: Colors.black87,
                  size: 32,
                )),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )
              ),
              child: ChatMessageList(),
            ),
            ),
            newMessage()
          ],
        ),
      )
      //buildContainer(context),
    );
  }

  /*Widget MessagesWidget(){
    return StreamBuilder( stream: FirebaseFirestore.instance
        .collection("ChatGroup").doc(widget.chatRoomId).collection("Chats").orderBy("timeStamp",descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
             reverse: true,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context,index){
                return MessageWidget(message : message)
              });
        }
        );
  }*/

  Widget newMessage(){
    return  Container(
      alignment: Alignment.bottomCenter,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Row(
        children: [
          Expanded(child: TextFormField(
            focusNode: focusNode,
            decoration: Style.fieldsDecoration(hintText: "Enter Message"),
            controller: message,

          )),
          GestureDetector(
            onTap: (){
              if(message.text.isNotEmpty) {
                print("sending");
                sendMessage().whenComplete(() => print("sent"));
              }
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        const Color(0x36FFFFFF),
                        const Color(0x0FFFFFFF)
                      ]
                  ),
                  borderRadius: BorderRadius.circular(40)
              ),
              padding: EdgeInsets.all(12),
              child: Icon(Icons.send),
            ),
          )
        ],
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      child: Stack(
        children: [

          Container(
            alignment: Alignment.bottomCenter,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            child: Row(

              children: [
                Expanded(child: TextFormField(
                  focusNode: focusNode,
                  decoration: Style.fieldsDecoration(hintText: "Enter Message"),
                  controller: message,

                )),
                GestureDetector(
                  onTap: (){
                    if(message.text.isNotEmpty) {
                      print("sending");
                      sendMessage().whenComplete(() => print("sent"));
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF)
                            ]
                        ),
                        borderRadius: BorderRadius.circular(40)
                    ),
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.send),
                  ),
                )
              ],
            ),
          ),

          Container(
              height: 600,
              width: MediaQuery.of(context).size.width*0.9,
              color: Colors.black87,
              child: ChatMessageList()),
        ],
      ),
    );
  }
}
