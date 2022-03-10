import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Controller{

  static Future<String> saveImage(File temp, String name) async{
    String link="";
    Reference storageReference = FirebaseStorage.instance.ref();
    Reference pictureFolderReference = storageReference.child("Pictures").child(name);
    await pictureFolderReference.putFile(temp).whenComplete(() async{
      link = await pictureFolderReference.getDownloadURL();
    });
    return link;
  }
}