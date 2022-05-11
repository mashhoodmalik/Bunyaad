import 'package:bunyaad/Model/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ServiceController{

  static Future<void> addService({required Service service}) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection("serviceinfo")
        .add(service.toJson());
    ref.update({"sid":ref.id});
  }



  static Future<void> updateService({required Service service}) async {
    await FirebaseFirestore.instance
        .collection("serviceinfo").doc(service.sid).update(service.toJson());

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