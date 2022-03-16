import 'package:bunyaad/Model/seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../Controller/controller.dart';
import '../../Controller/login_controller.dart';
import '../../Controller/seller_controller.dart';
import '../../Model/variables.dart';
import '../Model/Style.dart';
import '../Screens/login_screen.dart';
import '../Widgets/custom_widget.dart';

class SellerAccountSettings extends StatefulWidget {
  const SellerAccountSettings({Key? key}) : super(key: key);

  @override
  _SellerAccountSettingsState createState() => _SellerAccountSettingsState();
}

class _SellerAccountSettingsState extends State<SellerAccountSettings> {
  @override
  TextEditingController nameController = TextEditingController(
      text:
      Variables.isSeller ? Variables.seller!.name : Variables.buyer!.name);
  TextEditingController businessNameController = TextEditingController(
      text: Variables.isSeller
          ? Variables.seller!.businessName
          : Variables.seller!.businessName);
  TextEditingController phoneNumberController = TextEditingController(
      text: Variables.isSeller
          ? Variables.seller!.phoneNumber
          : Variables.seller!.phoneNumber);
  TextEditingController addressController = TextEditingController(
      text: Variables.isSeller
          ? Variables.seller!.address
          : Variables.seller!.address);
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
                        await SellerController.showImageSource(context);
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
                        backgroundImage: NetworkImage(Variables.seller!.imageLink),
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
                    controller: businessNameController,
                    decoration: Style.fieldsDecoration(hintText: "Business Name"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    enabled: isEditing,
                    controller: phoneNumberController,
                    decoration: Style.fieldsDecoration(hintText: "phoneNumber"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    enabled: isEditing,
                    controller: addressController,
                    decoration: Style.fieldsDecoration(hintText: "Address"),
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
                          businessNameController.text = Variables.isSeller
                              ? Variables.seller!.businessName
                              : Variables.seller!.businessName;
                          phoneNumberController.text = Variables.isSeller
                              ? Variables.seller!.phoneNumber
                              : Variables.seller!.phoneNumber;
                          addressController.text = Variables.isSeller
                              ? Variables.seller!.address
                              : Variables.seller!.address;
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
                              CustomWidget.circularProgressIndicator(context);
                              Seller sellerObject = Seller();
                              if(image!= null){
                                sellerObject.imageLink = await Controller.saveImage(image!, DateTime.now().microsecondsSinceEpoch.toString());
                              }
                              sellerObject.populateSeller(
                                  businessName: businessNameController,
                                  name: nameController,
                                  phoneNumber: phoneNumberController,
                                  address: addressController,
                                  email: emailController);
                              // buyerObject.imageLink =
                              await SellerController.updateSeller(
                                  seller: sellerObject);
                              setState(() {
                                nameController.text = Variables.isSeller
                                    ? Variables.seller!.name
                                    : Variables.buyer!.name;
                                businessNameController.text = Variables.isSeller
                                    ? Variables.seller!.businessName
                                    : Variables.seller!.businessName;
                                phoneNumberController.text = Variables.isSeller
                                    ? Variables.seller!.phoneNumber
                                    : Variables.seller!.phoneNumber;
                                addressController.text = Variables.isSeller
                                    ? Variables.seller!.address
                                    : Variables.seller!.address;
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
