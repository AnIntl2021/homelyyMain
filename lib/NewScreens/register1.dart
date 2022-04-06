import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'homellycolors.dart';

class Registernewone extends StatefulWidget {
  const Registernewone({Key key}) : super(key: key);

  @override
  _RegisternewoneState createState() => _RegisternewoneState();
}

class _RegisternewoneState extends State<Registernewone> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
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
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: 30),
                          child: Text('Register Now!',style: TextStyle(fontSize: 26,
                              fontWeight: FontWeight.bold),),
                        ),


                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(


                          filled: true,
                          fillColor: Colors.lightGreen[100],
                          hintText: "Enter E-mail",
                          contentPadding: EdgeInsets.only(left: 30,right: 0,top: 0,bottom: 0),

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
                          hintText: "Set Password",
                          contentPadding: EdgeInsets.only(left: 30,right: 0,top: 0,bottom: 0),


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
                          hintText: "Confirm Password",
                          contentPadding: EdgeInsets.only(left: 30,right: 0,top: 0,bottom: 0),


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








                  ],
                ),
              ),
            ),



          ),
        )
    );
  }
}
