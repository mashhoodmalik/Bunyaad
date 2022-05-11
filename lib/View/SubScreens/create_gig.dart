import 'dart:io';

import 'package:bunyaad/Model/service.dart';
import 'package:bunyaad/Model/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controller/buyer_controller.dart';
import '../../Controller/controller.dart';
import '../../Controller/service_controller.dart';
import '../Model/Style.dart';
import '../Widgets/custom_widget.dart';

class CreateGig extends StatefulWidget {
  const CreateGig({Key? key}) : super(key: key);

  @override
  _CreateGigState createState() => _CreateGigState();
}

class _CreateGigState extends State<CreateGig> {
  TextEditingController productName =
      TextEditingController();
  TextEditingController productPrice =
      TextEditingController();
  TextEditingController productDescription =
      TextEditingController();
  File? image;

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to capture image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundColor(),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "Bunyaad",
          style: Style.heading(),
        ),
        actions: [
          ClipOval(
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.switch_account_rounded,
                  color: Colors.black87,
                  size: 32,
                )),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            const SizedBox(
              height: 32,
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                child: Text(
                  "My Gig",
                  style: TextStyle(fontSize: 28),
                )),
            const SizedBox(
              height: 24,
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () async {
                ImageSource? source =
                    await ServiceController.showImageSource(context);
                await getImage(source!);
              },
              child: Container(
                // width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color:Colors.grey
                ),
                child: image != null
                    ? Image.file(image!)
                    : Icon(
                        Icons.image,
                        size: 100,
                      ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: productName,
              decoration: Style.fieldsDecoration(hintText: "product name"),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: productPrice,
              decoration: Style.fieldsDecoration(hintText: "product price"),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: productDescription,
              decoration:
                  Style.fieldsDecoration(hintText: "product description"),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: Style.primaryButtonStyle(),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                Spacer(),
                ElevatedButton(
                    style: Style.primaryButtonStyle(),
                    onPressed: () async {

                      Service createService= new Service();
                      createService.populateService(name: productName.text.toString(),
                      desc: productDescription.text.toString(),
                      price: productPrice.text,
                      sellerName: Variables.seller!.name,
                      sellerId: Variables.seller!.docId);
                      CustomWidget.circularProgressIndicator(context);
                      if(image!= null){
                        createService.image = await Controller.saveImage(image!, DateTime.now().microsecondsSinceEpoch.toString());
                      }

                      await ServiceController.addService(service: createService);
                      Navigator.pop(context);
                      Navigator.pop(context);


                    },
                    child: Text("Post")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
