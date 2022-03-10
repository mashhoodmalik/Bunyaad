import 'package:bunyaad/Controller/buyer_controller.dart';
import 'package:bunyaad/Controller/controller.dart';
import 'package:bunyaad/Model/variables.dart';
import 'package:bunyaad/View/Widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../Controller/login_controller.dart';
import '../../Model/buyer.dart';
import '../Model/Style.dart';
import '../Screens/login_screen.dart';

class BuyerAccountSettings extends StatefulWidget {
  const BuyerAccountSettings({Key? key}) : super(key: key);

  @override
  _BuyerAccountSettingsState createState() => _BuyerAccountSettingsState();
}

class _BuyerAccountSettingsState extends State<BuyerAccountSettings> {
  @override
  TextEditingController nameController = TextEditingController(
      text:
          Variables.isSeller ? Variables.seller!.name : Variables.buyer!.name);
  TextEditingController userNameController = TextEditingController(
      text: Variables.isSeller
          ? Variables.seller!.userName
          : Variables.buyer!.userName);
  TextEditingController emailController = TextEditingController(
      text: Variables.isSeller
          ? Variables.seller!.email
          : Variables.buyer!.email);
  File? image;

  bool isEditing = false;

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
                onPressed: () async {
                  LoginController.signout();
                  Fluttertoast.showToast(msg: "Logged Out");
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                },
                icon: Icon(
                  Icons.login,
                  color: Colors.black87,
                  size: 32,
                )),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 56),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "My Account",
                style: TextStyle(
                    fontSize: 28,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      if(isEditing) {
                        ImageSource? source =
                        await BuyerController.showImageSource(context);
                        await  getImage(source!);
                        // Variables.buyer.imageLink =
                      }
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: image!= null?CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(image!)
                        ):CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(Variables.buyer!.imageLink),
                    ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    enabled: isEditing,
                    controller: nameController,
                    decoration: Style.fieldsDecoration(hintText: "Name"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    enabled: isEditing,
                    controller: userNameController,
                    decoration: Style.fieldsDecoration(hintText: "User Name"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    enabled: false,
                    controller: emailController,
                    decoration: Style.fieldsDecoration(hintText: "Email"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      isEditing
                          ? ElevatedButton(
                              style: Style.primaryButtonStyle(),
                              onPressed: () async {
                                nameController.text = Variables.isSeller
                                    ? Variables.seller!.name
                                    : Variables.buyer!.name;
                                userNameController.text = Variables.isSeller
                                    ? Variables.seller!.userName
                                    : Variables.buyer!.userName;
                                isEditing = false;
                                setState(() {});
                              },
                              child: Text("Cancel"),
                            )
                          : SizedBox.shrink(),
                      isEditing
                          ? SizedBox(
                              width: 16,
                            )
                          : SizedBox.shrink(),
                      ElevatedButton(
                        style: Style.primaryButtonStyle(),
                        onPressed: () async {
                          if (!isEditing) {
                            isEditing = !isEditing;
                            setState(() {});
                          } else {
                            if (Variables.isSeller) {
                            } else if (!Variables.isSeller) {
                              // This means the user is buyer
                              CustomWidget.circularProgressIndicator(context);
                              Buyer buyerObject = Buyer();
                              if(image!= null){
                                buyerObject.imageLink = await Controller.saveImage(image!, DateTime.now().microsecondsSinceEpoch.toString());
                              }
                              buyerObject.populateBuyer(
                                  userName: userNameController,
                                  name: nameController,
                                  email: emailController);
                              // buyerObject.imageLink =
                              await BuyerController.updateBuyer(
                                  buyer: buyerObject);
                              setState(() {
                                nameController.text = Variables.isSeller
                                    ? Variables.seller!.name
                                    : Variables.buyer!.name;
                                userNameController.text = Variables.isSeller
                                    ? Variables.seller!.userName
                                    : Variables.buyer!.userName;
                                isEditing = false;
                              });
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Text(!isEditing ? "Edit" : "Update"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
