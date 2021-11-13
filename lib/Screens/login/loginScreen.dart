import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/login/phoneLogin.dart';
import 'package:homelyy/Screens/registeration/regestration.dart';
import 'package:homelyy/component/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  var phoneText = TextEditingController();
  var phoneerrorText;
  var codeerrorText;
  var phoneError = false;
  var codeError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "logo",
                  child: Image(
                    image: AssetImage("assets/homelyy.png"),
                    width:  Get.width*0.7,

                  ),
                ),
                Text(
                  "Login",
                  style: GoogleFonts.arvo(color: Colors.black, fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),

                buildTextField("Enter Phone Number","Phone",phoneText),

                SizedBox(
                  height: 30,
                ),

                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kdarkgreen)
                  ),
                    onPressed: () {
                      print("+91${phoneText.text}");

                      if (phoneText.text.length == 10) {
                        Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhoneLogin(
                                phoneNumber: "+91${phoneText.text}", key: Key("1223"),
                              )),
                              (route) =>
                          false, //if you want to disable back feature set to false
                        );
                      } else {
                        setState(() {
                          phoneError = true;
                          phoneerrorText = "Enter Correct Mobile Number";
                        });
                      }
                    },
                    child: Text("Send OTP"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hint,String label,TextEditingController controller) {
    return TextField(
      style: TextStyle(color:kdarkgreen),
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      // autofocus: true,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        hintStyle: TextStyle(),
        labelStyle: TextStyle(color: kgreen),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kgreen),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kgreen),
        ),

        // errorText: isdiscountAvailable ? erroText : null
      ),

      maxLength: 10,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      showCursor: true,
    );
  }
}