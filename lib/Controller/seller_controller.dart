import 'package:bunyaad/Model/seller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/variables.dart';


class SellerController {
  static Future<void> addSeller({required Seller seller}) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection("seller")
        .add(seller.toJSON());
    ref.update({"id":ref.id});
  }

  static Future<void> getSeller({required String email}) async {
    QuerySnapshot ref = await FirebaseFirestore.instance
        .collection("seller").where("email",isEqualTo: email).get();

    List<QueryDocumentSnapshot> data = ref.docs;
    for(int a = 0;a<data.length;a++){
      Variables.seller= new Seller();
      Variables.seller!.fromJSON(data[a].data());
      print("value");
      print(Variables.seller!.name);

    }
  }

  static Future<void> updateSeller({required Seller seller}) async {
    await FirebaseFirestore.instance
        .collection("seller").doc(Variables.seller!.docId).update(seller.toJSON());
  }
}