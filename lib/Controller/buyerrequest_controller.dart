
import 'package:bunyaad/Model/buyer_request_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class BuyerRequestController {
  static Future<void> addBuyer({required BuyerRequestClass buyerRequest}) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection("buyerRequests")
        .add(buyerRequest.toJSON());
    ref.update({"ID":ref.id});
  }


}