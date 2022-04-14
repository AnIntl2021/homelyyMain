import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:homelyy/NewScreens/homepage/homepagemain.dart';
import 'package:homelyy/NewScreens/register.dart';
import 'package:homelyy/component/constants.dart';

import '../Screens/NewScreens/Homepage/homepage_new.dart';
import '../Screens/NewScreens/homellycolors.dart';
import '../Screens/homepage/homepage.dart';
import '../component/api.dart';
import '../component/models.dart';



class LoginpageNew extends StatefulWidget {
  const LoginpageNew({Key key}) : super(key: key);

  @override
  _LoginpageNewState createState() => _LoginpageNewState();
}

class _LoginpageNewState extends State<LoginpageNew> {
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

  bool loading  = false;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold (

        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: 20),
                    child: Center(child: Image.asset('assets/homelyy.png',height: 100 ,)
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 15 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(

                          child: Container(


                            height: 30, width: Get.width * 0.5,
                            decoration: BoxDecoration(color: hmgreen,
                            borderRadius:   BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/guesticon.png'),
                            SizedBox(width: 7),
                            Text('login as Guest!',style:TextStyle(color: Colors.black),
                            ),
                              ]
                            ),




                          ),
                        ),






                      ],

                    ),


                  ),
                  Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: 30),
                        child: Text('Sign in ',style: TextStyle(fontSize: 26,
                            fontWeight: FontWeight.bold),),
                      ),


                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: phoneText,
                    decoration: InputDecoration(

                        filled: true,
                        fillColor: hmgreen,
                        hintText: "E-mail/Phone Number",
                        contentPadding: EdgeInsets.only(left: 100,right: 0,top: 0,bottom: 0),

                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        enabledBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        )

                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(

                        filled: true,
                        fillColor: hmgreen,
                        hintText: "Password",
                        contentPadding: EdgeInsets.only(left: 150,right: 0,top: 0,bottom: 0),


                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        enabledBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        )

                    ),
                  ),
                  SizedBox(height: 30),
               loading ? Center(
                 child: CircularProgressIndicator(color: kgreen,),
               ) :   InkWell(
                    onTap: (){
                        setState(() {
                          loading = true;
                        });
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
                            setState(() {
                              loading = false;
                            });
                          } else {


                            UserModel users =
                            UserModel().fromJson(jsonDecode(value));

                            if (users.password == passwordController.text) {
                              // await getAddress();
                              // var token =
                              //     await FirebaseMessaging.instance.getToken();
                              // print('token: $token');

                              // await AllApi().updateToken(
                              //     users.phone, token); // for updating token

                              await AllApi().updateLocalUsers(
                                  jsonEncode(users), users.phone);

                              print("getting user ${users.name}");

                              setState(() {
                                loading = false;
                              });

                              Get.off(MainHomePage(
                                userRef: users.phone
                                    .replaceAll("+", "")
                                    .removeAllWhitespace,
                              ));


                            } else {
                              Fluttertoast.showToast(msg: "Incorrect Password");
                              setState(() {
                                loading = false;
                              });
                            }
                          }
                        });

                      }

                      else

                      {

                        setState(() {
                          loading = false;
                        });

                      }

                    },
                    child: Container(
                      child:  Center(child: Text('Login',style:TextStyle(color:Colors.white),)),

                      height: 40,width: Get.width * 0.5,
                      decoration: (BoxDecoration(color: hmdarkolive, borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  SizedBox(height: 20),


                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          print('clickedf');


                          showDialog(context: context, builder: (context){
                            return    StatefulBuilder(
                                builder: (context, setState1) {
                                  return AlertDialog(
                                    backgroundColor:hmgreen,
                                    contentPadding : EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                                    shape: RoundedRectangleBorder(

                                        borderRadius: BorderRadius.circular(0),

                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(

                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text('Reset Password ',style: TextStyle(fontSize: 20,
                                                          color: Colors.lightGreen[500]),
                                                      ),

                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Text('Send code through',style: TextStyle(fontSize: 15,color: Colors.lightGreen[500]),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 15),
                                                  InkWell(
                                                    child: Container(
                                                      child:  Center(child: Text('Call Me',style:TextStyle(color:Colors.white),)),

                                                      height: 30, width: Get.width * 0.5,

                                                      decoration:  (BoxDecoration(color: Colors.lightGreen[500], borderRadius: BorderRadius.circular(30)
                                                      )
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  InkWell(
                                                    child: Container(
                                                      child:  Center(child: Text('Resend Code',style:TextStyle(color:Colors.white),)),

                                                      height: 30, width: Get.width * 0.5,

                                                      decoration:  (BoxDecoration(color: Colors.lightGreen[500], borderRadius: BorderRadius.circular(30)
                                                      )
                                                      ),


                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                ],
                                              ),

                                            ),
                                          )

                                        ],
                                      ),
                                    ),
                                  );
                                }
                            );
                          });
                        },

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Forgot password?'),
                            SizedBox(width: 10),
                            Text('Reset',style:TextStyle(color: Colors.lightGreen[500]) ,)
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            SizedBox(width: 10),
                            InkWell(
                                onTap: (){
                                  Get.to(RegisterNew());
                                }
                                ,
                                child: Text('Register',style:TextStyle(color: Colors.lightGreen[500]) ,))

                          ],
                        ),
                      ),

                    ],
                  )






                ],
              ),
            ),
          ),



        ),



      ),

    );
  }
}
