import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Controller/chat_controller.dart';
import '../../Model/chat_group.dart';
import '../../Model/variables.dart';
import '../Model/Style.dart';
import 'conversation_screen.dart';
import 'create_buyer_request.dart';

class SellerBuyerRequest extends StatefulWidget {
  const SellerBuyerRequest({Key? key}) : super(key: key);

  @override
  _SellerBuyerRequestState createState() => _SellerBuyerRequestState();
}

class _SellerBuyerRequestState extends State<SellerBuyerRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundColor(),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,)
        ),
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
              height: MediaQuery.of(context).size.height*0.05,
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text("Buyer Request",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.02,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40,vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  Text("Budget",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 24,),
                  Text("Action",style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.02,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("buyerRequests")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if (!snapshot.hasData){
                      return Center(
                        child:CircularProgressIndicator(),
                      );
                    }
                    return Container(
                      // width: 300,
                      // height: 300,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child:ListView(
                        children: snapshot.data!.docs.map((document){
                          return ListTile(
                            title: Text(document["description"]),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(document["budget"]),
                                SizedBox(width: 16,),
                                TextButton(onPressed: () {
                                  print("response");
                                }, child: Text("Response"))
                              ],
                            ),
                          );
                        }
                        ).toList(),
                      ) ,
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
