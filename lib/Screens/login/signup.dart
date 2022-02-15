import 'dart:convert';

import 'package:currency_picker/currency_picker.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/homepage/homepage.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _formKey = GlobalKey<FormState>();
  final _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  var userEmail = "";
  var userPhone = "";
  var userPassword = "";
  var userName = "";
  var userDOB = DateTime.now();
  var isloggedin = false;

  var refercode = "";

  var phone = "";

  var country;
  var symbol ;
  bool obsecureText = true;

  List countryList = [
    {'no': 1, 'keyword': 'India'},
    {'no': 2, 'keyword': 'Kuwait'},
    {'no': 3, 'keyword': 'Canada'},
    {'no': 4, 'keyword': 'UK'},
    {'no': 5, 'keyword': 'United States'},
    {'no': 6, 'keyword': 'Dubai'},
  ];

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
    if (picked != null) {
      setState(() {
        userDOB = picked;
      });
    }
  }

  Future<List<DropdownMenuItem<Object>>> buildDropdownTestItems(
      List _testList) async {
    List<DropdownMenuItem<Object>> items = [];
    // await for (var i in _testList) {
    //
    //  }

    await Future.forEach(_testList, (element) {
      items.add(
        DropdownMenuItem(
          value: element["no"],
          child: Text(element['keyword']),
        ),
      );
    });

    return items;
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
                          border: Border.all(color: Colors.green, width: 10),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Please note: We do not share your information outside we use it for your inApp activities",
                              style: GoogleFonts.arvo(
                                  color: kdarkgreen, fontSize: 10),
                            ),
                          ),
                          Text(
                            "Signup",
                            style: GoogleFonts.arvo(
                                color: kdarkgreen, fontSize: 18),
                          ),

                          InkWell(
                            onTap: (){
                              showCurrencyPicker(
                                context: context,
                                showFlag: true,
                                showCurrencyName: true,
                                showCurrencyCode: true,
                                onSelect: (Currency currency) {
                                  print('Select currency: ${currency.name}');
                                  setState(() {

                                    country = currency.code;
                                    symbol = currency.symbol;
                                  });

                                },
                                favorite: ['INR'],
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(15),
                              child: TextFormField(
                                enabled: false,
                                // The validator receives the text that the user has entered.
                                decoration: InputDecoration(
                                  hintText:  country == "" || country == null ? "Your Country" : country,
                                  labelText: country == "" || country == null ? "Your Country" : country,
                                  // hintStyle: TextStyle(color: Colors.white30),
                                  labelStyle: TextStyle(color: kgreen),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: kgreen),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: kgreen),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: kgreen),
                                  ),
                                  // errorText: isdiscountAvailable ? erroText : null
                                ),
                                validator: (value) {
                                  return null;
                                },

                              ),
                            ),
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
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Enter Phone",
                                labelText: "Phone Number",
                                // hintStyle: TextStyle(color: Colors.white30),
                                labelStyle: TextStyle(color: kgreen),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kgreen),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kgreen),
                                ),
                                counterText: ""
                                // errorText: isdiscountAvailable ? erroText : null
                              ),
                              validator: (value) {
                                if (value.isEmpty || !value.isPhoneNumber) {
                                  return 'Please enter Correct Phone Number';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                setState(() {
                                  userPhone = value;
                                });
                              },

                              onChanged: (value) {
                                setState(() {
                                  userPhone = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            child: TextFormField(
                              // The validator receives the text that the user has entered.
                              obscureText: obsecureText,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(onPressed: (){
                                  setState(() {

                                    obsecureText ?obsecureText = false :obsecureText = true ;

                                  });
                                }, icon: Icon(FontAwesomeIcons.eye,size: 18,)),
                                hintText: "Enter Password",
                                labelText: "Your Password",
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
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                setState(() {
                                  userPassword = value;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  userPassword = value;
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
                            onTap: () {
                              _selectstartDate(context);
                            },
                            child: Container(
                              margin: EdgeInsets.all(15),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(userDOB
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0]),
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
                                  print(
                                      "Got all text = user = $userName ref = $refercode email = $userEmail nme =$userName phone = $userPhone ");

                                  // AllApi().getUser(widget.phone.replaceAll("+", "").removeAllWhitespace?? "").then((value){
                                  //
                                  //
                                  // });
                                  //
                                  var referId = userName.substring(1,3) + userPhone.substring(6,10);

                                  if(country != null){
                                    AllApi()
                                        .postUser(UserModel(
                                        country: country,
                                        name: userName ?? "",
                                        address: "",
                                        ref: userPhone
                                            .replaceAll("+", "")
                                            .removeAllWhitespace ??
                                            "",
                                        email: userEmail ?? "",
                                        dob: userDOB
                                            .toLocal()
                                            .toString()
                                            .split(' ')[0] ??
                                            "",
                                        member: "",
                                        phone: userPhone
                                            .replaceAll("+", "")
                                            .removeAllWhitespace,
                                        token: "",
                                        wallet: "0",
                                        refFrom: refercode ?? '',
                                        referid: referId.toUpperCase(),
                                        password: userPassword,symbol:symbol))
                                        .then((value) async {

                                      if (value == "\"User Already Exist\"") {
                                        Fluttertoast.showToast(
                                            msg: "User Already Exist");
                                        Get.snackbar("User Already Exist",
                                            "Use another number",
                                            snackPosition: SnackPosition.BOTTOM,
                                            colorText: Colors.red);

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
                                      } else {
                                        var result = jsonDecode(value);

                                        UserModel users =
                                        UserModel().fromJson(result);

                                        AllApi()
                                            .updateLocalUsers(jsonEncode(users),users.phone);

                                        print(
                                            "getting user ${users.phone.replaceAll("+", "")}");

                                        Get.off(Homepage(
                                          userRef: users.phone
                                              .replaceAll("+", "")
                                              .removeAllWhitespace,
                                        ));
                                      }
                                    });
                                  }else{
                                    Fluttertoast.showToast(msg: "Please Add Country");
                                  }

                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(kdarkgreen)),
                              child: Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
    );
  }
}
