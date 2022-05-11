import 'package:bunyaad/Controller/order_controller.dart';
import 'package:bunyaad/Model/order.dart';
import 'package:bunyaad/Model/variables.dart';
import 'package:bunyaad/View/SubScreens/buyer_order.dart';
import 'package:bunyaad/View/SubScreens/conversation_screen.dart';
import 'package:bunyaad/View/Widgets/custom_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/Style.dart';

class SellerOrders extends StatefulWidget {

  @override
  _SellerOrdersState createState() => _SellerOrdersState();
}

class _SellerOrdersState extends State<SellerOrders> {
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
                child: orderRecordsSeller(),
              ),
              ),
              // newMessage()
            ],
          ),
        )
    );


  }


  Widget buildDescriptionCard(BuildContext context,Order order){

    return Container(
      margin: EdgeInsets.symmetric(horizontal:16),
      decoration: BoxDecoration(
        border: Border.all(),
        // borderRadius: BorderRadius.circular(25),
        // color:  Style.defaultHeadingColor,
      ),
      height: 150,
      width: MediaQuery.of(context).size.width*0.9,
      child: Column(
        children: [
          SizedBox(height: 8,),
          Text(order.productName,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 24),),
          SizedBox(height: 8,),
          Text("Buyer: "+order.buyerName,style: TextStyle(color: Colors.black87,fontSize: 16),),
          SizedBox(height: 8,),
          Text("Quantity: "+order.quantity),
          ElevatedButton(
              style: Style.primaryButtonStyle(),
              onPressed: ()async{
                if(order.isComplete != "complete") {
                  order.shipOrder(complete: "complete");
                  await OrderController.updateOrder(order: order);
                }
              }, child: Text("Deliver"))
        ],
      ),
    );
  }


  Widget orderRecordsSeller(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Orders").where("sellerId",isEqualTo: Variables.seller!.docId).where("confirm",isEqualTo: "confirm").where("isComplete",isEqualTo: "").snapshots(),//.doc(widget.chatRoomId).collection("Chats").orderBy("timeStamp",descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData){
            return const Center(
              child:CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document){
              // print("hello");
              Order order = new Order();
              order.fromJSON(document);
              return Container(
                  padding: EdgeInsets.all(16.0),
                  child: buildDescriptionCard(context, order));

                /*Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(onPressed: () async {
                        Order order = new Order();
                        order.fromJSON(document);
                        order.confirmOrder(confirm: "confirm");
                        await OrderController.updateOrder(order: order);

                      }, child: Text("Confirm")),
                      SizedBox(width: 8.0,),
                      ElevatedButton(onPressed: () async {
                        Order order = new Order();
                        order.fromJSON(document);
                        order.confirmOrder(confirm: "cancel");
                        await OrderController.updateOrder(order: order);
                      }, child: Text("Cancel")),
                    ],
                  ),
                  subtitle: Text("Customer: "+ document["buyerName"],style: TextStyle(color: Colors.white,fontSize: 15)),
                  title: Text(document["productName"],style: TextStyle(color: Colors.white,fontSize: 18)),
                ),
              );
*/
            }).toList(),
          );
        }
    );
  }


}
