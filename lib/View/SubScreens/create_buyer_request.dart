import 'package:bunyaad/Model/buyer_request_class.dart';
import 'package:bunyaad/Controller/buyerrequest_controller.dart';
import 'package:bunyaad/Model/variables.dart';
import 'package:bunyaad/View/Widgets/custom_widget.dart';
import 'package:flutter/material.dart';

import '../Model/Style.dart';

class CreateBuyerRequest extends StatefulWidget {
  const CreateBuyerRequest({Key? key}) : super(key: key);

  @override
  _CreateBuyerRequestState createState() => _CreateBuyerRequestState();
}

class _CreateBuyerRequestState extends State<CreateBuyerRequest> {
  TextEditingController description = TextEditingController();
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
                child:Text("Create Request",style: TextStyle(fontSize: 28),)
            ),
            SizedBox(height: 24,),
            Text("Describe what you are looking for: "),
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
               controller: description,
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
                  decoration: Style.createRequestFieldsDecoration(hintText: "Enter budget"),
                )),
            SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: Style.primaryButtonStyle(),
                    onPressed: ()async{

                      CustomWidget.circularProgressIndicator(context);
                      BuyerRequestClass buyerRequest = new BuyerRequestClass();
                      buyerRequest.populateBuyer(description: description ,timeDuration: timeLimit,budget:budget,buyerID: Variables.buyer!.docId);
                      await BuyerRequestController.addBuyer(buyerRequest: buyerRequest);
                      Navigator.pop(context);
                      Navigator.pop(context);

                    }, child: Text("Post")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
