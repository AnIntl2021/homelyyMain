import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class LoginpageNew extends StatefulWidget {
  const LoginpageNew({Key key}) : super(key: key);

  @override
  _LoginpageNewState createState() => _LoginpageNewState();
}

class _LoginpageNewState extends State<LoginpageNew> {
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
                            decoration: BoxDecoration(color: Colors.lightGreen[50],
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
                    decoration: InputDecoration(

                        filled: true,
                        fillColor: Colors.lightGreen[100],
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
                    decoration: InputDecoration(

                        filled: true,
                        fillColor: Colors.lightGreen[100],
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
                  InkWell(
                    child: Container(
                      child:  Center(child: Text('Login',style:TextStyle(color:Colors.white),)),

                      height: 40,width: Get.width * 0.5,
                      decoration: (BoxDecoration(color: Colors.lightGreen[500], borderRadius: BorderRadius.circular(30))),
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
                                    backgroundColor:Colors.lightGreen[50],
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
                            InkWell(child: Text('Register',style:TextStyle(color: Colors.lightGreen[500]) ,))

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
