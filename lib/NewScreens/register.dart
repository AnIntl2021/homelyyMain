import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../component/constants.dart';
import 'homellycolors.dart';

class RegisterNew extends StatefulWidget {
  const RegisterNew({Key key}) : super(key: key);

  @override
  _RegisterNewState createState() => _RegisterNewState();
}


class _RegisterNewState extends State<RegisterNew> {
  var country;
  var symbol ;
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
                  StepProgressIndicator(
                    totalSteps: 100,
                    currentStep: 12,
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
                      Padding(
                        padding:  EdgeInsets.only(left: 30),
                        child: Text('Register Now ',style: TextStyle(fontSize: 26,
                            fontWeight: FontWeight.bold),),
                      ),


                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: TextFormField(



                      decoration: InputDecoration(

                          filled: true,
                          fillColor: hmgreen,
                          hintText: "Your Name",
                          contentPadding: EdgeInsets.only(left: 40,right: 0,top: 0,bottom: 0),

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
                  ),
                  SizedBox(height: 15),
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

                    child: TextFormField(
                      enabled: true,
                      // The validator receives the text that the user has entered.
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: hmgreen,
                        hintText:  country == "" || country == null ? "Your Country" : country,
                        labelText: country == "" || country == null ? "Your Country" : country,
                        // hintStyle: TextStyle(color: Colors.white30),
                          contentPadding: EdgeInsets.only(left: 40,right: 0,top: 0,bottom: 0),

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

                        // errorText: isdiscountAvailable ? erroText : null
                      ),
                      validator: (value) {
                        return null;
                      },

                    ),
                  ),

                  // TextFormField(
                  //   enabled: false,
                  //   decoration: InputDecoration(
                  //
                  //       filled: true,
                  //       fillColor: hmgreen,
                  //       hintText: "Select Country",
                  //       contentPadding: EdgeInsets.only(left: 40,right: 0,top: 0,bottom: 0),
                  //       suffixIcon: Icon(Icons.arrow_drop_down),
                  //
                  //
                  //
                  //       border: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.white),
                  //         borderRadius: BorderRadius.all(Radius.circular(30)),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.white),
                  //         borderRadius: BorderRadius.all(Radius.circular(30)),
                  //       ),
                  //       enabledBorder:OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.white),
                  //         borderRadius: BorderRadius.all(Radius.circular(30)),
                  //       ),
                  //     disabledBorder:OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.white),
                  //       borderRadius: BorderRadius.all(Radius.circular(30)),
                  //     ),
                  //
                  //
                  //
                  //   ),
                  //
                  // ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: TextFormField(
                            decoration: InputDecoration(

                                filled: true,
                                fillColor: hmgreen,
                                hintText: "+91",
                                contentPadding: EdgeInsets.only(left: 40,right: 0,top: 0,bottom: 0),

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
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          child: TextFormField(
                            decoration: InputDecoration(

                                filled: true,
                                fillColor: hmgreen,
                                hintText: "Mobile Number",
                                contentPadding: EdgeInsets.only(left: 40,right: 0,top: 0,bottom: 0),

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
                        ),
                      ),
                    ],
                  ),





                  SizedBox(height: 30),
                  InkWell(
                    child: Container(
                      child:  Center(child: Text('Verify',style:TextStyle(color:Colors.white),)
                      ),

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
