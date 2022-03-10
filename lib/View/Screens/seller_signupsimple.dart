import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Controller/login_controller.dart';
import '../../Controller/seller_controller.dart';
import '../../Model/seller.dart';
import '../Model/Style.dart';
import '../Widgets/custom_widget.dart';

class SellerSignupSimple extends StatefulWidget {
  const SellerSignupSimple({Key? key}) : super(key: key);

  @override
  _SellerSignupSimpleState createState() => _SellerSignupSimpleState();
}

class _SellerSignupSimpleState extends State<SellerSignupSimple> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController taxIdController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundColor(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                "SignUp",
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
                  TextFormField(
                    controller: nameController,
                    decoration: Style.fieldsDecoration(hintText: "Name"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: userNameController,
                    decoration: Style.fieldsDecoration(hintText: "User Name"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: Style.fieldsDecoration(hintText: "Email"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: showPassword,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        enabledBorder: OutlineInputBorder(
                          gapPadding: 20,
                          borderSide: BorderSide(color: Colors.black87),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        errorBorder: OutlineInputBorder(
                          gapPadding: 20,
                          borderSide: BorderSide(color: Colors.black87),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          gapPadding: 20,
                          borderSide: BorderSide(color: Colors.black87),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        border: InputBorder.none,
                        hintText: "Password",
                        errorStyle: const TextStyle(fontSize: 12),
                        hintStyle: TextStyle(color: Colors.black45),
                        suffixIcon: IconButton(
                          icon: !showPassword
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        )),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: phoneNumberController,
                    decoration:
                        Style.fieldsDecoration(hintText: "Phone Number"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: Style.fieldsDecoration(hintText: "Address"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: cityController,
                    decoration: Style.fieldsDecoration(hintText: "City"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: taxIdController,
                    decoration: Style.fieldsDecoration(hintText: "Tax ID"),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    style: Style.primaryButtonStyle(),
                    onPressed: () async {
                      Seller sellerObject = new Seller();
                      sellerObject.populateSeller(
                          userName: userNameController,
                          name: nameController,
                          email: emailController,
                          phoneNumber: phoneNumberController,
                          address: addressController,
                          city: cityController,
                          taxId: taxIdController
                      );
                      CustomWidget.circularProgressIndicator(context);
                      bool user = await LoginController.registerEmail(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString(),
                          isSeller: true);
                      if (user) {
                        Navigator.pop(context);
                        await SellerController.addSeller(seller: sellerObject);
                        Fluttertoast.showToast(msg: "User created");
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: "User not created");
                      }
                    },
                    child: Text("SignUp"),
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
