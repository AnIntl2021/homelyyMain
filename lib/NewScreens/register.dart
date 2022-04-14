import 'dart:convert';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/NewScreens/homepage/homepagemain.dart';
import 'package:homelyy/NewScreens/register1.dart';
import 'package:homelyy/Screens/NewScreens/Homepage/chinese_new.dart';
import 'package:homelyy/Screens/NewScreens/Homepage/homepage_new.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../Screens/homepage/homepage.dart';
import '../component/api.dart';
import '../component/constants.dart';
import '../component/models.dart';
import 'homellycolors.dart';

class RegisterNew extends StatefulWidget {
  const RegisterNew({Key key}) : super(key: key);

  @override
  _RegisterNewState createState() => _RegisterNewState();
}


class _RegisterNewState extends State<RegisterNew> {
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone =  TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userConfirmPassword = TextEditingController();
  TextEditingController userName = TextEditingController();
  var userDOB = DateTime.now();
  var isloggedin = false;

  TextEditingController refercode = TextEditingController();

  var phone = "";

  var country;
  var symbol ;
  bool obsecureText = true;
  var prefix = '+91';

  int currentStep = 1;

  bool loading = false;


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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Please note: We do not share your information outside we use it for your inApp activities",
                      style: GoogleFonts.arvo(
                          color: kdarkgreen, fontSize: 10),
                    ),
                  ),
                  SizedBox(height: 10),
                  StepProgressIndicator(
                    totalSteps: 2,
                    currentStep: currentStep,
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
           currentStep == 2 ? Registernewone(email: userEmail,password: userPassword,confirmPassword: userConfirmPassword,
              refercode: refercode,
             function: (){

               print(
                   "Got all text = user = $userName ref = $refercode email = $userEmail nme =$userName phone = $userPhone ");

               // AllApi().getUser(widget.phone.replaceAll("+", "").removeAllWhitespace?? "").then((value){
               //
               //
               // });
               //


               if(country != null && userName.text.length > 4 && userPhone.text.isNotEmpty &&
               userEmail.text.isNotEmpty && userPassword.text.isNotEmpty
               ){

                 if(userPassword.text == userConfirmPassword.text){
                   var referId = userName.text.substring(1,3) + userPhone.text.substring(6,10);

                   AllApi()
                       .postUser(UserModel(
                       country: country,
                       name: userName.text ?? "",
                       address: "",
                       ref: userPhone.text
                           .replaceAll("+", "")
                           .removeAllWhitespace ??
                           "",
                       email: userEmail.text ?? "",
                       dob: userDOB
                           .toLocal()
                           .toString()
                           .split(' ')[0] ??
                           "",
                       member: "",
                       phone: userPhone.text
                           .replaceAll("+", "")
                           .removeAllWhitespace,
                       token: "",
                       wallet: "0",
                       refFrom: refercode.text ?? '',
                       referid: referId.toUpperCase(),
                       password: userPassword.text,symbol:symbol))
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

                       Get.off(MainHomePage(
                         userRef: users.phone
                             .replaceAll("+", "")
                             .removeAllWhitespace,
                       ));


                     }
                   });


                 }else{

                   Fluttertoast.showToast(msg: "Password Not Matched");



                 }

               }else{
                 Fluttertoast.showToast(msg: "All Fields are Mandatory");
               }


             },
           functionback: (){
             setState(() {
               currentStep = 1;
             });
           },
           )
               :       Column(
                    children: [
                      Container(
                        child: TextFormField(
                        controller: userName,


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
                            currencyFilter: ['KWD', 'INR', 'USD', 'QAR', 'SAR', 'AED', 'CAD'],
                            showCurrencyCode: true,
                            onSelect: (Currency currency) {
                              print('Select currency: ${currency.name}');
                              setState(() {

                                country = currency.code;
                                symbol = currency.symbol;

                                if(country == 'INR'){
                                  prefix = '+91';
                                }else if(country == 'USD'){
                                  prefix = '+1';
                                }else if(country == 'CAD'){
                                  prefix = '+1';
                                }else if(country == 'AED'){
                                  prefix = '+971';
                                }else if(country == 'SAR'){
                                  prefix = '+966';
                                }else if(country == 'KWD'){
                                  prefix = '+965';
                                }else if(country == 'QAR'){
                                  prefix = '+974';
                                }

                              });

                            },

                            favorite: ['INR'],
                          );
                        },

                        child: TextFormField(
                          enabled: false,
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
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),

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
                                    hintText: prefix,
                                    contentPadding: EdgeInsets.only(left: 40,right: 0,top: 0,bottom: 0),

                                    border: OutlineInputBorder(

                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.all(Radius.circular(30)),

                                    ),

                                    focusedBorder: OutlineInputBorder(

                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.all(Radius.circular(30)),

                                    ),

                                    enabledBorder: OutlineInputBorder(

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

                                controller: userPhone,

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
                        onTap: (){
                          setState(() {
                            currentStep = 2;
                          });
                        },
                        child: Container(
                          child:  Center(child: Text('Next',style:TextStyle(color:Colors.white),)
                          ),

                          height: 40,width: Get.width * 0.5,
                          decoration: (BoxDecoration(color: Colors.lightGreen[500], borderRadius: BorderRadius.circular(30))),
                        ),
                      ),






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
