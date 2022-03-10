import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../Model/Style.dart';

class SellerBuyerRequestResponse extends StatefulWidget {
  const SellerBuyerRequestResponse({Key? key}) : super(key: key);

  @override
  _SellerBuyerRequestResponseState createState() => _SellerBuyerRequestResponseState();
}

class _SellerBuyerRequestResponseState extends State<SellerBuyerRequestResponse> {
  TextEditingController response = TextEditingController();
  TextEditingController budget = TextEditingController();
  TextEditingController timeLimit = TextEditingController();
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
        title: Text("Bunyaad", style: Style.heading(),),
        actions: [
          ClipOval(
            child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.switch_account_rounded,color:Colors.black87,size: 32,)
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            SizedBox(height: 32,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child:Text("Respond To Request",style: TextStyle(fontSize: 28),)
            ),
            SizedBox(height: 24,),
            Text("Response",style: TextStyle(fontSize: 16),),
            SizedBox(height: 16,),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width*0.8,
              decoration: BoxDecoration(
                  border: Border.all()
              ),
              child: TextFormField(
                maxLines: 11,
                maxLength: 500,
                controller: response,
                decoration: Style.createRequestFieldsDecoration(hintText: "Message"),
              ),
            ),
            SizedBox(height: 24,),
            Text("Time Duration"),
            SizedBox(height: 16,),
            Container(
              // margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  //keyboardType: TextInputType.number,
                  controller: timeLimit,
                  decoration: Style.createRequestFieldsDecoration(hintText: "Enter Time Duration"),
                )),
            SizedBox(height: 24,),
            Text("Budget"),
            SizedBox(height: 16,),
            Container(
              // margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: budget,
                  decoration: Style.createRequestFieldsDecoration(hintText: "Enter price"),
                )),
            SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: Style.primaryButtonStyle(),
                    onPressed: ()async{

                    }, child: Text("Send")),
              ],
            )
          ],
        ),
      ),
    );
  }
}