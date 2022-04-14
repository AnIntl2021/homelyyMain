import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homelyy/NewScreens/contactus.dart';
import 'package:homelyy/NewScreens/homellycolors.dart';
import 'package:homelyy/NewScreens/pastorder.dart';
import 'package:homelyy/NewScreens/wallet.dart';
import 'package:homelyy/component/UserController.dart';
import 'package:homelyy/component/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../component/api.dart';
import '../component/models.dart';
import 'loginpage.dart';

class Accountsnew extends StatefulWidget {
  final String id;
  const Accountsnew({Key key, this.id}) : super(key: key);

  @override
  _AccountsnewState createState() => _AccountsnewState();
}

class _AccountsnewState extends State<Accountsnew> {
  @override
  Widget build(BuildContext context) {
    init();

    Get.find<UserController>().getUserList();

    return SafeArea(
      child: Scaffold(

        body: GetBuilder<UserController>(
          builder: (controller){
            return   Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 90,width: Get.width * 11,
                      color: hmgreen,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(

                          children: [
                            // Image.asset('assets/profile.png'),
                            SizedBox(width:15 ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Text(controller.userModel.name,style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                InkWell(
                                    child: Text(controller.userModel.phone,style: TextStyle(color: hmdarkolive),)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    InkWell(
                      onTap: (){
                        Get.to(Pastordernew(ref: controller.userModel.ref,));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child:  Row(
                                children: [
                                  Icon(Icons.list_alt_rounded,color: hmdarkolive,),
                                  SizedBox(width: 10),
                                  Text("My Orders"),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward,color: hmdarkolive,),
                          ],
                        ),
                      ),
                    ),
                    Divider(thickness: 1),


                    InkWell(
                      onTap: (){

                        Get.to(Walletnew(usermodel: controller.userModel,));

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child:  Row(
                                children: [
                                  Icon(Icons.account_balance_wallet_sharp,color: hmdarkolive,),
                                  SizedBox(width: 10),
                                  Text("My Wallet"),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward,color: hmdarkolive,),
                          ],
                        ),
                      ),
                    ),
                    Divider(thickness: 1),

                    // InkWell(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Container(
                    //           child:  Row(
                    //             children: [
                    //               Icon(Icons.logout,color: hmdarkolive,),
                    //               SizedBox(width: 10),
                    //               Text("Vouchers"),
                    //             ],
                    //           ),
                    //         ),
                    //         Icon(Icons.arrow_forward,color: hmdarkolive,),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Divider(thickness: 1),


                    InkWell(
                      onTap: () async {
                        var value = await AllApi()
                            .getUser(widget.id
                            .replaceAll("+", "")
                            .removeAllWhitespace);

                        UserModel users =
                        UserModel().fromJson(jsonDecode(value));
                        if(GetPlatform.isAndroid){
                          await FlutterShare.share(
                              title: 'Download Homelyy App Referal Code: ${users.referid} Get upto 5% Cashback on Every Order',
                              text: 'Download Homelyy App Referal Code:  ${users.referid} Get upto 5% Cashback on Every Order',
                              linkUrl: 'https://play.google.com/store/apps/details?id=com.an.homelyy.homelyy',
                              chooserTitle: 'Example Chooser Title'
                          );
                        }else{

                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child:  Row(
                                children: [
                                  Icon(Icons.logout,color: hmdarkolive,),
                                  SizedBox(width: 10),
                                  Text("Refer & Earn"),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward,color: hmdarkolive,),
                          ],
                        ),
                      ),
                    ),
                    Divider(thickness: 1),
                    InkWell(
                      onTap: (){
                          launch('https://www.thehomelyy.com/privacypolicy.php');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child:  Row(
                                children: [
                                  Icon(Icons.lock_clock,color: hmdarkolive,),
                                  SizedBox(width: 10),
                                  Text("Privacy Policy"),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward,color: hmdarkolive,),
                          ],
                        ),
                      ),
                    ),
                    Divider(thickness: 1),
                    InkWell(
                      onTap: (){
                        Get.to(Contactusnew());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child:  Row(
                                children: [
                                  Icon(Icons.call,color: hmdarkolive,),
                                  SizedBox(width: 10),
                                  Text("Contact us"),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward,color: hmdarkolive,),
                          ],
                        ),
                      ),
                    ),
                    Divider(thickness: 1),
                    InkWell(
                      onTap: () async {
                        SharedPreferences pref =  await SharedPreferences.getInstance();
                        pref.clear();
                        Get.offAll(LoginpageNew());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(

                          children: [
                            Icon(Icons.login_outlined,color: hmdarkolive,),
                            SizedBox(width: 15,),
                            Container(
                                child: Text("Logout")
                            ),

                          ],
                        ),
                      ),
                    ),







                  ],
                ),
              ),
            );
          },

        ),

      ),
    );
  }
}
