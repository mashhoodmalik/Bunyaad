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

class OrderDetail extends StatefulWidget {

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
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
                child: Variables.isSeller?orderRecordsSeller():orderRecordsBuyer(),
              ),
              ),
              // newMessage()
            ],
          ),
        )
    );
  }



  Widget orderRecordsBuyer(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Orders").where("buyerId",isEqualTo: Variables.buyer!.docId).snapshots(),//.doc(widget.chatRoomId).collection("Chats").orderBy("timeStamp",descending: false).snapshots(),
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
                    Order order = new Order();
                    order.fromJSON(document);
                    // order.placeOrder(buyerId: document[""], buyerName: buyerName, sellerId: sellerId, productName: productName, quantity: quantity)
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return
                            BuyerOrder(order: order);
                        },
                      ),
                    );
                  },
                  trailing: document["isComplete"]=="complete"?Text("Delivered"):document["confirm"]=="cancel"?Text("Canceled"):Text("Pending"),
                  subtitle: Text("Quantity: "+ document["quantity"],style: TextStyle(color: Colors.white,fontSize: 15)),
                  title: Text(document["productName"],style: TextStyle(color: Colors.white,fontSize: 18)),
                ),
              );

            }).toList(),
          );
        }
    );
  }

  Widget orderRecordsSeller(){
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Orders").where("sellerId",isEqualTo: Variables.seller!.docId).where("confirm",isEqualTo: "pending").snapshots(),//.doc(widget.chatRoomId).collection("Chats").orderBy("timeStamp",descending: false).snapshots(),
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

            }).toList(),
          );
        }
    );
  }


}
