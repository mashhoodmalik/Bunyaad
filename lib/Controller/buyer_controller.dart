import 'package:bunyaad/Model/buyer.dart';
import 'package:bunyaad/Model/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class BuyerController {
  static Future<void> addBuyer({required Buyer buyer}) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection("buyers")
        .add(buyer.toJSON());
    ref.update({"id": ref.id});
  }

  static Future<void> getBuyer({required String email}) async {
    QuerySnapshot ref = await FirebaseFirestore.instance
        .collection("buyers")
        .where("email", isEqualTo: email)
        .get();

    List<QueryDocumentSnapshot> data = ref.docs;
    for (int a = 0; a < data.length; a++) {
      Variables.buyer = Buyer();
      Variables.buyer!.fromJSON(data[a].data());
      print("value");
      print(Variables.buyer!.name);
    }
  }

  static Future<void> updateBuyer({required Buyer buyer}) async {
    await FirebaseFirestore.instance
        .collection("buyers")
        .doc(Variables.buyer!.docId)
        .update(buyer.toJSON());
    await getBuyer(email: buyer.email);
  }

  static Future<ImageSource?> showImageSource(BuildContext context) async {
    return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) => CupertinoActionSheet(
              title: Text("Select an Image Source"),
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () =>
                      Navigator.of(context).pop(ImageSource.camera),
                  child: Text("Camera"),
                ),
                CupertinoActionSheetAction(
                  onPressed: () =>
                      Navigator.of(context).pop(ImageSource.gallery),
                  child: Text("Gallery"),
                ),
              ],
            ));
  }
}
