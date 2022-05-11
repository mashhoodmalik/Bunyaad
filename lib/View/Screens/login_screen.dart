import 'package:bunyaad/Model/variables.dart';
import 'package:bunyaad/View/Screens/dashboard_screen.dart';
import 'package:bunyaad/View/Screens/seller_dashboard.dart';
import 'package:bunyaad/View/Screens/signup_screen.dart';
import 'package:bunyaad/View/Widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Controller/login_controller.dart';
import '../Model/Style.dart';
import 'create_seller_account.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Style.backgroundColor(),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 160),
            Container(
              alignment: Alignment.center,
              child: Text("Bunyaad", style: Style.heading()),
            ),
            SizedBox(height: 80),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  // keyboardType: TextInputType.number,
                  controller: emailController,
                  decoration: Style.fieldsDecoration(hintText: "Enter Email"),
                )),
            SizedBox(
              height: 24,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  obscureText: showPassword,
                  controller: passwordController,
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
                      hintText: "Enter Password",
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
                )),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
                style: Style.primaryButtonStyle(),
                onPressed: () async {
                  print("Logged in");

                  print(emailController.text.toString());
                  print(passwordController.text.toString());
                  CustomWidget.circularProgressIndicator(context);
                  bool loginAttempt = await LoginController.login(
                      emailController.text.toString(),
                      passwordController.text.toString());
                  if (loginAttempt) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: "Logged In");
                    if (Variables.isSeller) {
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SellerDashboard();
                          },
                        ),
                      );

                    } else {
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const DashboardScreen();
                          },
                        ),
                      );
                    }
                  } else {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: "Wrong credientials");
                  }
                },
                child: Text("Login")),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
                style: Style.primaryButtonStyle(buttonColor: Colors.grey),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const Signup();
                      },
                    ),
                  );
                },
                child: Text("Signup")),
            SizedBox(
              height: 24,
            ),
            Text("or"),
            SizedBox(
              height: 16,
            ),
            TextButton(
                onPressed: () async {
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const CreateSellerAccount();
                      },
                    ),
                  );
                },
                child: Text(
                  "Create seller account",
                  style: TextStyle(
                      color: Colors.black87,
                      fontStyle: FontStyle.italic,
                      fontSize: 18),
                )),
            SizedBox(height: 160),
          ],
        ),
      ),
    );
  }
}
