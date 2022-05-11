import 'package:bunyaad/Model/variables.dart';
import 'package:bunyaad/View/SubScreens/edit_gig.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Model/Style.dart';
import '../Widgets/Search.dart';
import '../Widgets/custom_widget.dart';
import 'create_gig.dart';

class SellerGig extends StatefulWidget {
  const SellerGig({Key? key}) : super(key: key);

  @override
  _SellerGigState createState() => _SellerGigState();
}

class _SellerGigState extends State<SellerGig> {
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
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: Style.primaryButtonStyle(),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CreateGig();
                          },
                        ),
                      );
                    },
                    child: Text("Create Gig")),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: getGigTile(),
            )
          ],
        ),
      ),
    );
  }

  Widget getGigTile() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("serviceinfo")
            .where("uid", isEqualTo: Variables.seller!.docId)
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
                    document["sid"]),
              );
            }).toList(),
          );
        });
  }

  Widget buildDescriptionCard(BuildContext context, String image,
      String productName, String productDesc, String productPrice,String sid) {
    return GestureDetector(
      onTap: ()async{
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return
                EditGig(productPrice: productPrice, productName: productName, productDescription: productDesc,
                  isEditNotValue: true,imageLink: image,serviceId : sid);
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
                IconButton(onPressed: () async {

                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return
                          EditGig(productPrice: productPrice, productName: productName, productDescription: productDesc,
                          isEditNotValue: false,imageLink: image,serviceId: sid);
                      },
                    ),
                  );
                }, icon: Icon(Icons.edit)),
                IconButton(onPressed: () async{
                  CustomWidget.circularProgressIndicator(context);
                  await FirebaseFirestore.instance
                      .collection("serviceinfo").doc(sid).delete();

                  Navigator.pop(context);
                }, icon: Icon(Icons.delete))
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
