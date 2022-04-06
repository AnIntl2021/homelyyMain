import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'homellycolors.dart';

class Verifytwo extends StatefulWidget {
  const Verifytwo({Key key}) : super(key: key);

  @override
  _VerifytwoState createState() => _VerifytwoState();
}

class _VerifytwoState extends State<Verifytwo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                    StepProgressIndicator(
                      totalSteps: 100,
                      currentStep: 32,
                      size: 8,
                      padding: 0,
                      selectedColor: hmgreen,
                      unselectedColor: hmolive,
                      roundedEdges: Radius.circular(10),
                      selectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [hmolive, hmolive],
                      ),
                      unselectedGradientColor: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [hmgreen, hmgreen],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text('Verify Now ',style: TextStyle(fontSize: 26,
                                fontWeight: FontWeight.bold),),
                            SizedBox(height: 10),
                            Text('Enter 4-digit code'),


                          ],
                        ),
                      ],
                    ),

                    // Container(
                    //   child: TextFormField(
                    //     decoration: InputDecoration(
                    //
                    //         filled: true,
                    //         fillColor: hmgreen,
                    //         hintText: "Your Name",
                    //         contentPadding: EdgeInsets.only(left: 40,right: 0,top: 0,bottom: 0),
                    //
                    //         border: OutlineInputBorder(
                    //           borderSide: BorderSide(color: Colors.white),
                    //           borderRadius: BorderRadius.all(Radius.circular(30)),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(color: Colors.white),
                    //           borderRadius: BorderRadius.all(Radius.circular(30)),
                    //         ),
                    //         enabledBorder:OutlineInputBorder(
                    //           borderSide: BorderSide(color: Colors.white),
                    //           borderRadius: BorderRadius.all(Radius.circular(30)),
                    //         )
                    //
                    //     ),
                    //   ),
                    // ),


                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: 65,

                            child: TextFormField(
                              decoration: InputDecoration(


                                  filled: true,
                                  fillColor: hmdarkgreen,
                                  hintText: " ",
                                  contentPadding: EdgeInsets.only(left: 40,right: 0,top: 0,bottom: 0),

                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color:homered),
                                    borderRadius: BorderRadius.all(Radius.circular(9)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: homered),
                                    borderRadius: BorderRadius.all(Radius.circular(9)),
                                  ),
                                  enabledBorder:OutlineInputBorder(
                                    borderSide: BorderSide(color: homered),
                                    borderRadius: BorderRadius.all(Radius.circular(9)
                                    ),
                                  )

                              ),
                            ),
                          ),
                        ),
                        SizedBox(width:13),
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: 65,
                            child: TextFormField(
                              decoration: InputDecoration(

                                  filled: true,
                                  fillColor: hmdarkgreen,
                                  hintText: " ",
                                  contentPadding: EdgeInsets.only(left: 40,right: 0,top: 0,bottom: 0),

                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: homered),
                                    borderRadius: BorderRadius.all(Radius.circular(9)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: homered),
                                    borderRadius: BorderRadius.all(Radius.circular(9)),
                                  ),
                                  enabledBorder:OutlineInputBorder(
                                    borderSide: BorderSide(color: homered),
                                    borderRadius: BorderRadius.all(Radius.circular(9)),
                                  )

                              ),
                            ),
                          ),
                        ),
                        SizedBox(width:13),
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: 65,
                            child: TextFormField(
                              decoration: InputDecoration(

                                  filled: true,
                                  fillColor: hmdarkgreen,
                                  hintText: " ",
                                  contentPadding: EdgeInsets.only(left: 40,right: 0,top: 0,bottom: 0),

                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color:homered),
                                    borderRadius: BorderRadius.all(Radius.circular(9)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color:homered),
                                    borderRadius: BorderRadius.all(Radius.circular(9)),
                                  ),
                                  enabledBorder:OutlineInputBorder(
                                    borderSide: BorderSide(color: homered),
                                    borderRadius: BorderRadius.all(Radius.circular(9)),
                                  )

                              ),
                            ),
                          ),
                        ),
                        SizedBox(width:13),
                        Flexible(
                          flex: 1,
                          child: Container(

                            width: 65,
                            child: TextFormField(
                              decoration: InputDecoration(

                                  filled: true,
                                  fillColor: hmdarkgreen,
                                  hintText: " ",
                                  contentPadding: EdgeInsets.only(left: 40,right: 0,top: 0,bottom: 0),

                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: homered),
                                    borderRadius: BorderRadius.all(Radius.circular(9)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: homered),
                                    borderRadius: BorderRadius.all(Radius.circular(9)),
                                  ),
                                  enabledBorder:OutlineInputBorder(
                                    borderSide: BorderSide(color: homered),
                                    borderRadius: BorderRadius.all(Radius.circular(9)),
                                  )

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Entered code is niot right!',style: TextStyle(color: homered),),
                      ],
                    ),





                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: Container(
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Continue',style:TextStyle(color:Colors.white),

                                ),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward,color: Colors.white,),

                              ],

                            ),



                            height: 40,width: Get.width * 0.5,
                            decoration: (BoxDecoration(color: hmolive, borderRadius: BorderRadius.circular(30))),
                          ),

                        ),

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


                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      children: [

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
                                                    SizedBox(height: 10),
                                                    InkWell(
                                                        child: Text('Continue',style: TextStyle(color: hmolive),)
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


                          child:Text("Didn't recived code ?"),
                        )
                      ],
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
