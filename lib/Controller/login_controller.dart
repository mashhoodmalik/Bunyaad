import 'package:bunyaad/Controller/buyer_controller.dart';
import 'package:bunyaad/Controller/seller_controller.dart';
import 'package:bunyaad/Model/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  static Future<bool> login(String email, String password) async {
    bool returnValue = false;
    try {
      await Variables.auth!
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value.user != null) {
          // await BuyerController.getBuyer(email: email);
          bool isSeller = await checkSeller(email: email);
          if(!isSeller){
            print("this is buyer");
            await BuyerController.getBuyer(email: email);
            Variables.isSeller = false;
          }
          else{
            print("this is seller");
            await SellerController.getSeller(email: email);
            Variables.isSeller = true;
          }
          returnValue = true;
          return returnValue;
        }
        return false;
      });
    } on FirebaseException catch (e) {
      print(e);
      returnValue = false;
    }
    return returnValue;
  }

  static Future<bool> registerEmail(
      {required String email,
      required password,
      required bool isSeller}) async {
    bool returnValue = false;
    try {
      await Variables.auth!
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value.user != null) {
          print("user created");
          if (isSeller) {
            await FirebaseFirestore.instance
                .collection("user")
                .add({"email": email, "isSeller": "1"});
          } else {
            await FirebaseFirestore.instance
                .collection("user")
                .add({"email": email, "isSeller": "0"});
          }

          returnValue = true;
          return returnValue;
        }
        return false;
      });
    } on FirebaseException catch (e) {
      print(e);
      returnValue = false;
    }
    return returnValue;
  }

  static Future<void> signout() async {
    await Variables.auth!.signOut();
  }

  static Future<bool> checkSeller({required String email}) async {
    QuerySnapshot ref = await FirebaseFirestore.instance
        .collection("user")
        .where("email", isEqualTo: email)
        .get();
    List<QueryDocumentSnapshot> data = ref.docs;
    for (int a = 0; a < data.length; a++) {
     return fromJSON(data[a].data());
    }
    return false;
  }

  static bool fromJSON(var doc) {
    //print(doc["email"]);
    var isSeller = doc["isSeller"];
    if (isSeller == "1") {
      return true;
    } else {
      return false;
    }
  }
}
