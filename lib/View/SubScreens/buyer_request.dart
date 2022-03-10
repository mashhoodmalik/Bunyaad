import 'package:bunyaad/Model/variables.dart';
import 'package:bunyaad/View/SubScreens/create_buyer_request.dart';
import 'package:bunyaad/View/Widgets/custom_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/Style.dart';

class BuyerRequest extends StatefulWidget {
  const BuyerRequest({Key? key}) : super(key: key);

  @override
  _BuyerRequestState createState() => _BuyerRequestState();
}

class _BuyerRequestState extends State<BuyerRequest> {
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
              height: 32,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Buyer Request",
                      style: TextStyle(fontSize: 28),
                    ),
                    Spacer(),
                    ElevatedButton(
                        style: Style.primaryButtonStyle(),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const CreateBuyerRequest();
                              },
                            ),
                          );
                        },
                        child: Text("Create +"))
                  ],
                )),
            SizedBox(
              height: 24,
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text("Sent",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("buyerRequests")
                      .where("buyerId", isEqualTo: Variables.buyer!.docId)
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
                      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                      child:ListView(
                        children: snapshot.data!.docs.map((document){
                          return ListTile(
                            title: Text(document["description"]),
                          trailing: Text(document["budget"]),
                          );}).toList(),
                      ) ,
                    );
                }
              ),
            )
            /*StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("buyerRequests")
                    .where("buyerId", isEqualTo: Variables.buyer!.docId)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  switch(snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    default:
                      if(!snapshot.hasData){
                        return const Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if(snapshot.hasError){
                        return Text(snapshot.error.toString());
                      }else {
                        return ListView(
                          children: snapshot.data!.docs.map((e) => Text(""))
                        );
                      }
                  }

                })*/
          ],
        ),
      ),
    );
  }
}
