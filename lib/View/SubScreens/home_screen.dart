import 'package:bunyaad/Controller/chat_controller.dart';
import 'package:bunyaad/Model/chat_group.dart';
import 'package:bunyaad/Model/variables.dart';
import 'package:bunyaad/View/Model/Style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Widgets/Search.dart';
import 'conversation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FocusNode focusNode = FocusNode();
  bool isLiked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundColor(),
      appBar: AppBar(
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
                onPressed: () {},
                icon: Icon(
                  Icons.switch_account_rounded,
                  color: Colors.black87,
                  size: 32,
                )),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SearchBar(
                  searchFunction: () {},
                  onChanged: (value) {},
                  focusNode: focusNode),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: getAllSellerTile(),
              /* ListView.separated(
                  itemCount: 5,
                  itemBuilder: (BuildContext context,index){
                return buildDescriptionCard(context);
              }, separatorBuilder: (BuildContext context, int index) {
                    return Container(height: 12,);
              },),*/
            )
          ],
        ),
      ),
    );
  }

  Widget getAllSellerTile() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("seller").snapshots(),
        //.doc(widget.chatRoomId).collection("Chats").orderBy("timeStamp",descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              // print("hello");
              return Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.blue,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(
                  // tileColor: Colors.blue,
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Style.defaultHeadingColor),
                    onPressed: () async {
                      String value =
                          await ChatController.getChatGroupSeller(document["id"]);
                      if (value == "-1") {
                        ChatGroup chatGroup = ChatGroup();
                        chatGroup.populateBuyer(
                            chatRoomId: "",
                            seller: document["id"],
                            sellerName: document["email"],
                            buyer: Variables.buyer!.docId,
                            buyerName: Variables.buyer!.name);
                        chatGroup.chatRoomId =
                            await ChatController.createChatGroup(chatGroup);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ConversationScreen(
                                  chatRoomId: chatGroup.chatRoomId,
                                  userId: Variables.buyer!.docId);
                            },
                          ),
                        );
                      }
                      else{
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ConversationScreen(
                                  chatRoomId: value,
                                  userId: Variables.buyer!.docId);
                            },
                          ),
                        );
                      }
                    },
                    child: Text("Chat"),
                  ),
                  onTap: () async {
                    /*
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return
                           // ConversationScreen(chatRoomId: document["chatRoomId"], userId: Variables.buyer!.docId);
                        },
                      ),
                    );*/
                  },
                  title: Text(
                    document["email"],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              );
            }).toList(),
          );
        });
  }

  Widget buildDescriptionCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(),
        // borderRadius: BorderRadius.circular(25),
        // color:  Style.defaultHeadingColor,
      ),
      height: 200,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  color: Colors.black87,
                  height: 100,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () {
                        isLiked = !isLiked;
                        setState(() {});
                      },
                      child: isLiked == true
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : Icon(Icons.favorite_border))),
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
                      Text(
                        "Item Name",
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Short Description",
                        style: TextStyle(
                            color: Colors.black87,
                            fontStyle: FontStyle.italic,
                            fontSize: 16),
                      )
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
