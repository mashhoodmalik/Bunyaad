import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/order.dart';
import '../Model/variables.dart';

class OrderController{

  static Future<void> addOrder({required Order order}) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection("Orders")
        .add(order.toJSON());
    ref.update({"id": ref.id});
  }
  static Future<void> updateOrder({required Order order}) async {
    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(order.orderId)
        .update(order.toJSON());
  }
}