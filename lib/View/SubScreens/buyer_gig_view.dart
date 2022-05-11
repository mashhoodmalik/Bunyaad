import 'package:bunyaad/Controller/order_controller.dart';
import 'package:bunyaad/Model/order.dart';
import 'package:bunyaad/Model/service.dart';
import 'package:bunyaad/Model/variables.dart';
import 'package:bunyaad/View/SubScreens/buyer_order.dart';
import 'package:bunyaad/View/Widgets/custom_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../Controller/buyer_controller.dart';
import '../../Controller/chat_controller.dart';
import '../../Controller/controller.dart';
import '../../Controller/service_controller.dart';
import '../../Model/chat_group.dart';
import '../Model/Style.dart';
import 'conversation_screen.dart';

class BuyerGigView extends StatefulWidget {
  String productName;
  String productDescription;
  String productPrice;
  String productId;
  String sellerName;
  String imageLink;
  String sellerId;

  BuyerGigView(
      {required this.productPrice,
        required this.productName,
        required this.productDescription,
        required this.imageLink,
        required this.sellerName,
        required this.productId,
        required this.sellerId});

  @override
  _BuyerGigViewState createState() => _BuyerGigViewState();
}

class _BuyerGigViewState extends State<BuyerGigView> {
  bool isEdit = true;
  TextEditingController productName =
  TextEditingController(text: "Product Name");
  TextEditingController productPrice =
  TextEditingController(text: "Product Price");
  TextEditingController productDescription =
  TextEditingController(text: "Product Description");
  File? image;

  @override
  void initState() {
    // TODO: implement initState
    productDescription.text = widget.productDescription;
    productName.text = widget.productName;
    productPrice.text = widget.productPrice;
  }

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to capture image");
    }
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            SizedBox(
              height: 32,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Text(
                  widget.sellerName,
                  style: TextStyle(fontSize: 28),
                )),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: Style.primaryButtonStyle(),
                    onPressed: ()async{
                      Order order = new Order();
                      order.placeOrder(buyerId: Variables.buyer!.docId,
                          buyerName: Variables.buyer!.name,
                          sellerId: widget.sellerId,
                          productId: widget.productId,
                          productName: widget.productName,
                          quantity: "3");
                      CustomWidget.showOrderBox(context, widget.productName,order);


                    },
                    child: Text("Order")),
                 SizedBox(
                   width: 16,
                 ),
                 ElevatedButton(
                    style: Style.primaryButtonStyle(),
                    onPressed: () async {String value =
                        await ChatController.getChatGroupBuyer(widget.sellerId,Variables.buyer!.docId);
                    if (value == "-1") {
                      ChatGroup chatGroup = ChatGroup();
                      chatGroup.populateBuyer(
                          chatRoomId: "",
                          seller: widget.sellerId,
                          sellerName: widget.sellerName,
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
                    child: Text("Chat"))
              ],
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () async {
                if (!isEdit) {
                  ImageSource? source =
                  await BuyerController.showImageSource(context);
                  await getImage(source!);
                }
              },
              child: Container(
                // width: 200,
                height: 200,
                color: Colors.grey,

                child: image != null
                    ? Image.file(image!)
                    : Image.network(widget.imageLink),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            isEdit
                ? Text(productName.text)
                : TextFormField(
              controller: productName,
              decoration:
              Style.fieldsDecoration(hintText: "product name"),
            ),
            SizedBox(
              height: 16,
            ),
            isEdit
                ? Text(productPrice.text)
                : TextFormField(
              controller: productPrice,
              decoration:
              Style.fieldsDecoration(hintText: "product price"),
            ),
            SizedBox(
              height: 16,
            ),
            isEdit
                ? Text(productDescription.text)
                : TextFormField(
              controller: productDescription,
              decoration:
              Style.fieldsDecoration(hintText: "product description"),
            ),
            SizedBox(
              height: 24,
            ),
            Text("Review",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            SizedBox(
              height: 24,
            ),
            SizedBox(
                height: 400,
                child: reviewBuilder()),


          ],
        ),
      ),
    );
  }


  Widget reviewBuilder(){

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("serviceinfo").doc(widget.productId).collection("review").limit(5)
            .snapshots(),

        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData){
            return const Center(
              child:CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document){

              return Container(
                // height: 150,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        document["review"],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: false,
                          ),
                      SizedBox(height: 8.0,),
                      Text("Review by: "+document["buyer"],style: TextStyle(color:Colors.blue,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
                    ],
              ));
            }).toList(),
          );
        }
    );
  }
}
