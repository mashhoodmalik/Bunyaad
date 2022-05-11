
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Controller/order_controller.dart';
import '../../Model/order.dart';
import '../Model/Style.dart';
import '../SubScreens/buyer_order.dart';

class CustomWidget{

  static Future<void> circularProgressIndicator(BuildContext context)async{
    await showDialog(barrierDismissible: false,context: context, builder: (context){

      return Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            color: Style.defaultHeadingColor,
            backgroundColor: Colors.white,
          ),
        ),
      );

    });
  }

  static Future<void> showOrderBox(BuildContext context,String productName,Order order)async{

    TextEditingController controller = new TextEditingController();

    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (_,__,___){
          return Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                height: 200,
                width: 300,
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Style.defaultHeadingColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Text(productName,style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 16.0,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text("Quantity",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        SizedBox(width: 24.0,),
                        SizedBox(
                          width: 60,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                              controller: controller,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[300],
                                enabledBorder: const OutlineInputBorder(
                                  gapPadding: 20,
                                  borderSide: BorderSide(color: Colors.black87),

                                ),
                                disabledBorder: const OutlineInputBorder(
                                  gapPadding: 20,
                                  borderSide: BorderSide(color: Colors.black87),

                                ),
                                errorBorder: const OutlineInputBorder(
                                  gapPadding: 20,
                                  borderSide: BorderSide(color: Colors.black87),

                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  gapPadding: 20,
                                  borderSide: BorderSide(color: Colors.black87),

                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black87),
                                ),
                                contentPadding: const EdgeInsets.all(10),
                                border: InputBorder.none,
                                hintText: "0",
                                errorStyle: const TextStyle(fontSize: 12),
                                hintStyle: TextStyle(color: Colors.black45),
                              )
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0,),
                    ElevatedButton(onPressed: ()async{
                      Navigator.pop(context);

                      order.quantity = controller.text;
                      await OrderController.addOrder(order: order);
                      circularProgressIndicator(context);
                      Navigator.pop(context);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BuyerOrder(order: order);
                          },
                        ),
                      );

                      }, child: const Text("Confirm"),)

                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  static void showReviewBox(BuildContext context,String productId,String buyerName){

    TextEditingController controller = new TextEditingController();

    showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 500),
    pageBuilder: (_,__,___){
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            height: 350,
            width: 350,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Style.defaultHeadingColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Review",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
                const SizedBox(height: 16.0,),
                TextFormField(
                  maxLines: 10,
                  controller: controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    enabledBorder: const OutlineInputBorder(
                      gapPadding: 20,
                      borderSide: BorderSide(color: Colors.black87),

                    ),
                    disabledBorder: const OutlineInputBorder(
                      gapPadding: 20,
                      borderSide: BorderSide(color: Colors.black87),

                    ),
                    errorBorder: const OutlineInputBorder(
                      gapPadding: 20,
                      borderSide: BorderSide(color: Colors.black87),

                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      gapPadding: 20,
                      borderSide: BorderSide(color: Colors.black87),

                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    border: InputBorder.none,
                    hintText: "Write your review here",
                    errorStyle: const TextStyle(fontSize: 12),
                    hintStyle: TextStyle(color: Colors.black45),
                  )
                ),
                const SizedBox(height: 8.0,),
                ElevatedButton(onPressed: ()async{
                  Navigator.pop(context);
                  circularProgressIndicator(context);
                  await FirebaseFirestore.instance
                      .collection("serviceinfo").doc(productId).collection("review").add({
                    "review":controller.text,
                    "buyer":buyerName
                  });
                  Navigator.pop(context);
                }, child: Text("Send"))
              ],
            ),
          ),
        ),
      );
    }
  );
  }
}