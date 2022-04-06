import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';



class Loginpagea extends StatefulWidget {
  const Loginpagea({Key key}) : super(key: key);

  @override
  _LoginpageaState createState() => _LoginpageaState();
}

class _LoginpageaState extends State<Loginpagea> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold (

        body: Container(
          child: SingleChildScrollView(
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
                          decoration: BoxDecoration(color: Colors.lightGreenAccent[100],
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
                Padding(
                  padding:   EdgeInsets.all(8.0),
                  child: Card(color:Colors.lightGreen[100],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.red.shade200)
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(

                          filled: true,
                          fillColor: Colors.lightGreen[100],
                          hintText: "E-mail/Phone Number",
                          contentPadding: EdgeInsets.only(left: 100,right: 0,top: 0,bottom: 0),

                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen[100]),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen[100]),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          enabledBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen[100]),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          )

                      ),
                    ),



                  ),
                ),





                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(color:Colors.lightGreen[100],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color:Colors.red.shade200)
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(

                          filled: true,
                          fillColor: Colors.lightGreen[100],
                          hintText: "Password",
                          contentPadding: EdgeInsets.only(left: 150,right: 0,top: 0,bottom: 0),


                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen[100]),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.lightGreen[100]),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          enabledBorder:OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.lightGreen[100]),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          )

                      ),
                    ),



                  ),
                ),


                SizedBox(height: 20,),
                Text('username or Password entered dose not match!',style: TextStyle(color: Colors.red[200]),),

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Forgot password?'),
                        SizedBox(width: 10),
                        InkWell(child: Text('Reset',style:TextStyle(color: Colors.lightGreen[500]) ,))
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        SizedBox(width: 10),
                        InkWell(child: Text('Register',style:TextStyle(color: Colors.lightGreen[500]) ,))

                      ],
                    ),

                  ],
                )






              ],
            ),
          ),



        ),



      ),

    );
  }
}

