import 'package:bunyaad/Controller/chat_controller.dart';
import 'package:bunyaad/Model/chat_group.dart';
import 'package:bunyaad/Model/variables.dart';
import 'package:bunyaad/View/Model/Style.dart';
import 'package:bunyaad/View/SubScreens/buyer_gig_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Widgets/Search.dart';
import 'conversation_screen.dart';
import 'edit_gig.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FocusNode focusNode = FocusNode();
  bool isLiked = true;

  String searchText = "";
  bool isSearched = false;
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
                  searchFunction: () {

                    if( searchText != "") {
                      focusNode.unfocus();
                      setState(() {
                          isSearched =true;
                        });
                    }
                    
                  },
                  onChanged: (value) {
                    if(value.isEmpty){
                      isSearched = false;
                      searchText = "";
                      setState(() {

                      });

                    }
                    else{
                      
                      searchText = value.toString();
                    }
                    
                  },
                  focusNode: focusNode),
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: isSearched?searchGigTile(searchText):getGigTile(),
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



  Widget searchGigTile(String searchName) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("serviceinfo").where("NameL",arrayContains: searchName.toLowerCase())
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: buildDescriptionCard(
                    context,
                    document["userimage"],
                    document["Name"],
                    document["Description"],
                    document["Price"],
                    document["sid"],
                    document["uid"],
                    document["sellerName"],
                    // document["sid"]
                ),
              );
            }).toList(),
          );
        });
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
              return

                Container(
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
                      //Checks if the buyer has already a chat group with seller or not?? document[id] is seller id
                      String value =
                          await ChatController.getChatGroupBuyer(document["id"],Variables.buyer!.docId);

                      if (value == "-1") {
                        // this code block works if buyer has no chat group with seller
                        ChatGroup chatGroup = ChatGroup();
                        chatGroup.populateBuyer(
                            chatRoomId: "",
                            seller: document["id"],
                            sellerName: document["name"],
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

                        // works if room is already created
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




  Widget getGigTile() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("serviceinfo")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: buildDescriptionCard(
                    context,
                    document["userimage"],
                    document["Name"],
                    document["Description"],
                    document["Price"],
                    document["sid"],
                    document["uid"],
                    document["sellerName"],
                ),
              );
            }).toList(),
          );
        });
  }

  Widget buildDescriptionCard(BuildContext context, String image,
      String productName, String productDesc, String productPrice,String sid,String sellerID,String sellerName,
      ) {
    return GestureDetector(
      onTap: ()async{
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return
                BuyerGigView(
                  productId: sid,productPrice: productPrice, productName: productName, productDescription: productDesc,imageLink: image, sellerId : sellerID, sellerName: sellerName,);
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        height: 250,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Style.defaultHeadingColor),
                  onPressed: () async {
                    String value =
                    await ChatController.getChatGroupBuyer(sellerID,Variables.buyer!.docId);
                    if (value == "-1") {
                      ChatGroup chatGroup = ChatGroup();
                      chatGroup.populateBuyer(
                          chatRoomId: "",
                          seller: sellerID,
                          sellerName: sellerName,
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
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 110,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(image),
                  )),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Text(
                          productName,
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          productDesc,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
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
                    child: Text(productPrice),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
