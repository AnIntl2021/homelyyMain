import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/UserProfile/UserInfo.dart';
import 'package:homelyy/Screens/homepage/homepage.dart';
import 'package:homelyy/Screens/login/phoneLogin.dart';
import 'package:homelyy/Screens/login/signup.dart';
import 'package:homelyy/Screens/registeration/regestration.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/models.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart' as coder;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var phoneText = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var passwordErrorText;
  var passwordError;
  var phoneerrorText;
  var codeerrorText;
  var phoneError = false;
  var codeError = false;
  bool obsecureText = true;

  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  var userLatitude = "";
  var userLongitude = "";

  Future<LocationData> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        Get.snackbar("Error",
            "'Location service is disabled. Please enable it to check-in.'");
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        Get.snackbar("Error",
            "'Location service is disabled. Please enable it to check-in.'");
        return null;
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }

  Future<List<coder.Address>> getAddress() async {
    getLocation().then((value) async {
      final coordinates = coder.Coordinates(value.latitude, value.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print(" : ${first.addressLine}");

      var pref = await SharedPreferences.getInstance();
      pref.setString("address", first.addressLine);
      pref.setString("code", first.postalCode);
      return addresses;
    });
  }

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
                    width: Get.width * 0.7,
                  ),
                ),
                Text(
                  "Login",
                  style: GoogleFonts.arvo(color: Colors.black, fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                buildTextField(
                    "Enter Registered Phone Number", "Phone", phoneText),
                buildTextField(
                    "Enter Password", "Password", passwordController),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kdarkgreen)),
                    onPressed: () {

                      print("+${phoneText.text}");

                      if (phoneText.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        AllApi()
                            .getUser(phoneText.text
                                .replaceAll("+", "")
                                .removeAllWhitespace)
                            .then((value) async {
                          if (value == "\"User Not Exist\"") {
                            Fluttertoast.showToast(
                                msg: "User Not Exist Please Signup");
                          } else {
                            UserModel users =
                                UserModel().fromJson(jsonDecode(value));

                            if (users.password == passwordController.text) {
                              await getAddress();
                              var token =
                                  await FirebaseMessaging.instance.getToken();
                              print('token: $token');

                              await AllApi().updateToken(
                                  users.phone, token); // for updating token

                              await AllApi().updateLocalUsers(
                                  jsonEncode(users), users.phone);

                              print("getting user ${users.name}");

                              Get.off(Homepage(
                                userRef: users.phone,
                              ));
                            } else {
                              Fluttertoast.showToast(msg: "Incorrect Password");
                            }
                          }

                        });
                      } else {
                        setState(() {
                          phoneError = true;
                          phoneerrorText =
                              "Enter Correct Mobile Number with country code";
                        });
                      }
                    },
                    child: Text("Login")),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {

                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        content:
                        Scaffold(
                          body: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('We will send your password on your registered Email',style: TextStyle(fontWeight:FontWeight.bold ),),


                                  buildTextFieldNew("Enter Registered Email Id",
                                      "Email", emailController),


                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(Colors.white)),
                                      onPressed: () async {

                                        if(emailController.text.isNotEmpty){
                                          var userGetURL = Uri.parse("https://thehomelyy.com/forgotmail.php?email=${emailController.value.text}");
                                          print('user ${emailController.value.text}');
                                          var response = await http.get(userGetURL);
                                          Fluttertoast.showToast(msg: 'Password sent on your mail ${response.body}');
                                          Get.to(LoginScreen(

                                          ));
                                        }else{

                                          Fluttertoast.showToast(msg: 'Enter Email');

                                        }






                                      },
                                      child: Text(
                                        "Send",
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Forgot Password ? "),
                      Text(
                        "Reset now",
                        style:
                            GoogleFonts.arvo(color: Colors.red, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.to(SignUp());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont have an Account ? "),
                      Text(
                        "Signup",
                        style:
                            GoogleFonts.arvo(color: Colors.red, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      Get.to(Homepage(
                        userRef: 'Guest',
                      ));
                    },
                    child: Text(
                      "Login as Guest",
                      style: TextStyle(color: Colors.grey),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String hint, String label, TextEditingController controller) {
    return TextField(
      style: TextStyle(color: kdarkgreen),
      controller: controller,
      keyboardType:
          label == "Phone" ? TextInputType.number : TextInputType.text,
      obscureText: label == "Phone" ? false : obsecureText,
      textAlign: TextAlign.center,

      // autofocus: true,
      decoration: InputDecoration(
        suffixIcon: label == "Phone" || label == "Email"
            ? null
            : IconButton(
                onPressed: () {
                  setState(() {
                    obsecureText ? obsecureText = false : obsecureText = true;
                  });
                },
                icon: Icon(
                  FontAwesomeIcons.eye,
                  size: 18,
                )),
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
      showCursor: true,
    );
  }


  Widget buildTextFieldNew(
      String hint, String label, TextEditingController controller) {
    return TextField(
      style: TextStyle(color: kdarkgreen),
      controller: controller,
      keyboardType:
      label == "Phone" ? TextInputType.number : TextInputType.text,
      obscureText: false ,
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
      showCursor: true,
    );
  }

}
