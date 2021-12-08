
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:homelyy/Screens/UserProfile/UserInfo.dart';
import 'package:homelyy/Screens/homepage/homepage.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/models.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginScreen.dart';
import 'package:geocoder/geocoder.dart' as coder;

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



  Location location = Location() ;

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  var userLatitude = "";
  var userLongitude = "";

  Future<LocationData>getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      print("requesting permisssion");
      _serviceEnabled = await location.requestService();

      if (!_serviceEnabled) {

        print("requested permisssion $_serviceEnabled");
        Fluttertoast.showToast(msg: "Please enable location");
        getLocation();

      }else{


        print("requested again permisssion $_serviceEnabled");
        getLocation();

      }
    }else{

    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        Fluttertoast.showToast(msg: "Please enable location");
        getLocation();
      }
    }

    var latlmng = await location.getLocation();
    return latlmng ;

  }

  Future<List<coder.Address>>getAddress(LocationData locationdata) async {

    // From a query



    // final query = "1600 Amphiteatre Parkway, Mountain View";



    // var addresses = await Geocoder.local.findAddressesFromQuery(query);



    // var first = addresses.first;



    // print("${first.featureName} : ${first.coordinates}");



    // From coordinates


    final coordinates =  coder.Coordinates(locationdata.latitude, locationdata.longitude);

    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);

    var first = addresses.first;

    print(" : ${first.addressLine}");

    var pref = await SharedPreferences.getInstance();

    pref.setString("address", first.addressLine);

    pref.setString("code", first.postalCode);

    return addresses;

  }



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

          Fluttertoast.showToast(msg: "Login Success UID: ${userCredential.user?.uid}");

            AllApi().getUser(widget.phoneNumber.replaceAll("+", "").removeAllWhitespace).then((value) async {
              if(value == "\"User Not Exist\""){

                print("no user");
                var latlng = await getLocation();

                await getAddress(latlng);

                Get.to(UserInfoScreen(phone:widget.phoneNumber.replaceAll("+", "").removeAllWhitespace));

              }
              else{

                var latlng = await getLocation();
                await getAddress(latlng);
                UserModel users = UserModel().fromJson(jsonDecode(value));
                await AllApi().updateLocalUsers(jsonEncode(users), users.phone);
                print("getting user ${users.name}");

                Get.off(Homepage(userRef: users.phone,));

              }

            });






        },
        onLoginFailed: (authException) {
          print("An error occurred again: ${authException.message}");
          Fluttertoast.showToast(msg: "An error occurred again: ${authException.message}").then((value) {
            setState(() {
              Get.to(LoginScreen());
          });



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
                    await controller.verifyOTP(otp: _enteredOTP).then((value) {
                      Fluttertoast.showToast(msg:
                      "Something went wrong $value",

                      ).then((value) {
                        setState(() {
                          verifyingOTP = false;
                        });
                      });

                    });

                    // Incorrect OTP
                    if (!res){
                      Fluttertoast.showToast(msg:
                        "Please enter the correct OTP sent to ${widget.phoneNumber}",

                      );
                      setState(() {
                        verifyingOTP = false;
                      });
                    }

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