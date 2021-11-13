
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:homelyy/Screens/UserProfile/UserInfo.dart';
import 'package:homelyy/Screens/homepage/homepage.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/models.dart';
import 'loginScreen.dart';

class PhoneLogin extends StatefulWidget {
  final String phoneNumber;
  const PhoneLogin({
     Key key,
     this.phoneNumber,
  }) : super(key: key);
  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  var _enteredOTP;
  var userName;
  bool verifyingOTP = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FirebasePhoneAuthHandler(
        phoneNumber: widget.phoneNumber,
        timeOutDuration: const Duration(seconds: 60),
        onLoginSuccess: (userCredential, autoVerified) async {
          print(autoVerified
              ? "OTP was fetched automatically"
              : "OTP was verified manually");

          print("Login Success UID: ${userCredential.user?.uid}");

            AllApi().getUser(widget.phoneNumber).then((value) {
              if(value == "User Not Exist"){
                print("no user");
                Get.to(UserInfoScreen());
              }else{
                UserModel users = UserModel().fromJson(value);
                print("getting user ${users.name}");
                Get.off(Homepage());
              }

            });

            AllApi().postUser(UserModel(
                 name:"Arsalan",
                 address:"Arsalan",
                 ref:"Arsalan",
                 email:"Arsalan",
                 dob:"Arsalan",
                 location: {
                "name": "type",

          },
                 member:"Arsalan",
                 phone:"Arsalan",
                 token:"Arsalan",
                 wallet:"Arsalan"
            ));




        },
        onLoginFailed: (authException) {
          print("An error occurred: ${authException.message}");
          setState(() {
            verifyingOTP = false;
          });// handle error further if needed
        }, builder: (conyext , controller ) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Verification Code"),
            backgroundColor: Colors.black,
            actions: controller.codeSent
            ? [
            TextButton(
              child: Text(
                controller.timerIsActive
                    ? "${controller.timerCount.inSeconds}s"
                    : "RESEND",
                style: TextStyle(color: Colors.blue, fontSize: 18),
              ),
              onPressed: controller.timerIsActive
                  ? null
                  : () async {
                await controller.sendOTP();
              },
            ),
            SizedBox(width: 5),
            ]
            : null,
          ),
          body: controller.codeSent
              ? verifyingOTP ? Center(child: CircularProgressIndicator(color: Colors.green,)) : ListView(
            padding: EdgeInsets.all(20),
            children: [
              Text(
                "We've sent an SMS with a verification code to ${widget.phoneNumber}",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 10),
              Divider(),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                height: controller.timerIsActive ? null : 0,
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 50),
                    Text(
                      "Listening for OTP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Divider(),
                    Text("OR", textAlign: TextAlign.center),
                    Divider(),
                  ],
                ),
              ),
              Text(
                "Enter Code Manually",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextField(
                maxLength: 6,
                keyboardType: TextInputType.number,
                onChanged: (String v) async {
                  _enteredOTP = v;
                  if (this._enteredOTP?.length == 6) {
                    setState(() {
                      verifyingOTP = true;
                    });


                    final res =
                    await controller.verifyOTP(otp: _enteredOTP);

                    // Incorrect OTP
                    if (!res)
                      Fluttertoast.showToast(msg:
                        "Please enter the correct OTP sent to ${widget.phoneNumber}",
                      );
                  }
                },
              ),
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 50),
              Center(
                child: Text(
                  "Sending OTP",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        );
      },
      ),
    );
  }
}