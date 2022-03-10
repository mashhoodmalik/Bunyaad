import 'package:bunyaad/Controller/buyer_controller.dart';
import 'package:bunyaad/Controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Model/buyer.dart';
import '../Model/Style.dart';
import '../Widgets/custom_widget.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundColor(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text(
          "Bunyaad",
          style: Style.heading(),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.black87,
                    fontStyle: FontStyle.italic,
                    fontSize: 18),
              )),
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
                    height: 24,
                  ),
                  ElevatedButton(
                    style: Style.primaryButtonStyle(buttonColor: Colors.grey),
                    onPressed: () async{
                      Buyer buyerObject = new Buyer();
                      buyerObject.populateBuyer(userName: userNameController,name: nameController,email: emailController);

                      CustomWidget.circularProgressIndicator(context);
                      bool user = await LoginController.registerEmail(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString(),
                        isSeller: false
                      );
                      if(user){
                        Navigator.pop(context);
                        BuyerController.addBuyer(buyer: buyerObject);
                        Fluttertoast.showToast(msg: "User created");
                        Navigator.pop(context);
                      }
                      else{
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: "User not created");
                      }
                    },
                    child: Text("SignUp"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text("or"),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff192b8d),
                      fixedSize: Size(180, 30),
                    ),
                    onPressed: () async {

                    },
                    child: Text("Sign Up with Google"),
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
