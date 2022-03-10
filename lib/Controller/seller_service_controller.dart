
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/seller_service_class.dart';


class SellerServiceController {

  static Future<void> addSevice({required SellerServiceClass sellerService}) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection("sellerService")
        .add(sellerService.toJSON());
    ref.update({"ID":ref.id});
  }


}