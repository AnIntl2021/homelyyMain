// @dart=2.9
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/homepage/homepage.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/models.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserInfoScreen extends StatefulWidget {
  final String phone;

  const UserInfoScreen({Key key, this.phone}) : super(key: key);
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  var _formKey = GlobalKey<FormState>();
  final _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  var userEmail = "";
  var userName = "";
  var userDOB = DateTime.now();
  var isloggedin = false ;
  var refercode = "" ;

  Future addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedin', true).then((value) {
      prefs.setBool("token", true);
    });
  }

  _selectstartDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: userDOB, // Refer step 1
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    );
    if (picked != null){
      setState(() {
        userDOB = picked;
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                          width: 10
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "ENTER FEW MORE DETAILS",
                      style: GoogleFonts.arvo(
                          color: kdarkgreen, fontSize: 18),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: TextFormField(
                        // The validator receives the text that the user has entered.
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          labelText: "Email Address",
                          // hintStyle: TextStyle(color: Colors.white30),
                          labelStyle: TextStyle(color: kgreen),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kgreen),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kgreen),
                          ),

                          // errorText: isdiscountAvailable ? erroText : null
                        ),
                        validator: (value) {
                          if (value.isEmpty || !value.isEmail) {
                            return 'Please enter Correct email address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            userEmail = value;
                          });

                        },

                        onChanged: (value) {
                          setState(() {
                            userEmail = value;
                          });

                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: TextFormField(
                        // The validator receives the text that the user has entered.
                        decoration: InputDecoration(
                          hintText: "Enter Name",
                          labelText: "Full Name",
                          // hintStyle: TextStyle(color: Colors.white30),
                          labelStyle: TextStyle(color: kgreen),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kgreen),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kgreen),
                          ),

                          // errorText: isdiscountAvailable ? erroText : null
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            userName = value;
                          });

                        },
                        onChanged: (value) {
                          setState(() {
                            userName = value;
                          });

                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.all(15),
                      child: TextFormField(
                        // The validator receives the text that the user has entered.
                        decoration: InputDecoration(
                          hintText: "Referral Code",
                          labelText: "Referral Code",
                          // hintStyle: TextStyle(color: Colors.white30),
                          labelStyle: TextStyle(color: kgreen),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kgreen),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kgreen),
                          ),

                          // errorText: isdiscountAvailable ? erroText : null
                        ),
                        validator: (value) {
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            refercode = value;
                          });

                        },
                        onChanged: (value) {
                          setState(() {
                            refercode = value;
                          });

                        },
                      ),
                    ),

                    Text("ENTER YOUR DATE OF BIRTH"),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: (){
                        _selectstartDate(context);
                      },
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                                userDOB.toLocal().toString().split(' ')[0]),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState.validate()) {
                            print("Got all text = user = $userName ref = $refercode email = $userEmail ");

                            AllApi().postUser(UserModel(
                                name:userName ?? "",
                                address:"",
                                ref:widget.phone.replaceAll("+", "").removeAllWhitespace?? "",
                                email:userEmail?? "",
                                dob:userDOB.toLocal().toString().split(' ')[0]?? "",
                                member:"",
                                phone:widget.phone.replaceAll("+", "").removeAllWhitespace,
                                token:"",
                                wallet:"0",
                              refFrom: refercode
                            )).then((value) async {
                              if(value == "\"User Not Exist\"" || value == "\"User Already Exist\""){

                                Fluttertoast.showToast(msg: "User Already Exist");
                                Get.snackbar("User Already Exist", "Use another number",snackPosition: SnackPosition.BOTTOM,colorText: Colors.red);

                                //  AllApi().getUser(widget.phone).then((value) {
                                //    print("UserError ${widget.phone}  ${value}}");
                                //
                                //         AllApi().updateLocalUsers(value).then((value) {
                                //
                                //           addBoolToSF().then((value) {
                                //             Get.offAll(Homepage());
                                //           });
                                //
                                //
                                //         });
                                //
                                // });
                              }else{

                                var result = jsonDecode(value);

                                UserModel users = UserModel().fromJson(result);

                                AllApi().updateLocalUsers(jsonEncode(users));

                                print("getting user ${users.phone.replaceAll("+", "")}");

                                Get.off(Homepage(userRef: users.phone.replaceAll("+", "").removeAllWhitespace,));

                              }

                            });

                          }
                        },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kdarkgreen)),
                        child: Text('Submit'),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
