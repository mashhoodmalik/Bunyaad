import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../Controller/buyer_controller.dart';
import '../../Controller/chat_controller.dart';
import '../../Model/chat_group.dart';
import '../../Model/variables.dart';
import '../Model/Style.dart';
import 'conversation_screen.dart';

class SellerAccountView extends StatefulWidget {
  String sellerName;
  String address;
  String businessName;
  String city;
  String phoneNumber;
  String imageLink;
  String sellerId;

  SellerAccountView(
      {required this.sellerName,
        required this.address,
        required this.businessName,
        required this.city,
        required this.phoneNumber,
        required this.imageLink,
        required this.sellerId});

  @override
  _SellerAccountViewState createState() => _SellerAccountViewState();
}

class _SellerAccountViewState extends State<SellerAccountView> {
  bool isEdit = true;
  TextEditingController sellerName =
  TextEditingController(text: "Seller Name");
  TextEditingController address =
  TextEditingController(text: "Address");
  TextEditingController city =
  TextEditingController(text: "City");
  TextEditingController phoneNumber =
  TextEditingController(text: "phoneNumber");
  TextEditingController businessName =
  TextEditingController(text: "Business Name");
  File? image;

  @override
  void initState(){
    sellerName.text = widget.sellerName;
    address.text = widget.address;
    city.text = widget.city;
    phoneNumber.text = widget.phoneNumber;
    businessName.text = widget.businessName;
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
                    "Seller Account",
                    style: TextStyle(
                        fontSize: 28,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Style.defaultHeadingColor),
                      onPressed: () async {
                        //Checks if the buyer has already a chat group with seller or not?? document[id] is seller id
                        String value =
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
                    ? Text(sellerName.text)
                    : TextFormField(
                  controller: sellerName,
                  decoration:
                  Style.fieldsDecoration(hintText: "seller name"),
                ),
                SizedBox(
                  height: 16,
                ),
                isEdit
                    ? Text(address.text)
                    : TextFormField(
                  controller: address,
                  decoration:
                  Style.fieldsDecoration(hintText: "address"),
                ),
                SizedBox(
                  height: 16,
                ),
                isEdit
                    ? Text(phoneNumber.text)
                    : TextFormField(
                  controller: phoneNumber,
                  decoration:
                  Style.fieldsDecoration(hintText: "phone number"),
                ),
                isEdit
                    ? Text(city.text)
                    : TextFormField(
                  controller: city,
                  decoration:
                  Style.fieldsDecoration(hintText: "city"),
                ),
                isEdit
                    ? Text(businessName.text)
                    : TextFormField(
                  controller: businessName,
                  decoration:
                  Style.fieldsDecoration(hintText: "business name"),
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
        ),
    );
  }
}
