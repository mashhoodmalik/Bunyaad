import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Controller/login_controller.dart';
import '../../Controller/seller_controller.dart';
import '../../Model/seller.dart';
import '../Model/Style.dart';
import '../Widgets/custom_widget.dart';

class SellerSignup extends StatefulWidget {
  const SellerSignup({Key? key}) : super(key: key);

  @override
  _SellerSignupState createState() => _SellerSignupState();
}

class _SellerSignupState extends State<SellerSignup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
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
            onPressed: (){Navigator.pop(context);},
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,)
        ),
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
              child: Text("SignUp", style: TextStyle(fontSize: 28,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),),
            ),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 32),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration:  Style.fieldsDecoration(hintText: "Name"),
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: userNameController,
                    decoration:  Style.fieldsDecoration(hintText: "User Name"),
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: emailController,
                    decoration:  Style.fieldsDecoration(hintText: "Email"),
                  ),
                  SizedBox(height: 16,),
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
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: phoneNumberController,
                    decoration:  Style.fieldsDecoration(hintText: "Phone Number"),
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: addressController,
                    decoration:  Style.fieldsDecoration(hintText: "Address"),
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: cityController,
                    decoration:  Style.fieldsDecoration(hintText: "City"),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 36),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff192b8d),
                  fixedSize: Size(130, 30),),
                onPressed: (){},
                child: Text("Upload Degree"),
              )
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(40.0),
                child: ElevatedButton(
                  style: Style.primaryButtonStyle(buttonColor: Colors.grey),
                  onPressed: ()async{

                  },
                  child: Text("SignUp"),
                )
            ),
          ],
        ),
      ),
    );
  }
}
