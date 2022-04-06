import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:homelyy/NewScreens/homellycolors.dart';

class Accountsnew extends StatefulWidget {
  const Accountsnew({Key key}) : super(key: key);

  @override
  _AccountsnewState createState() => _AccountsnewState();
}

class _AccountsnewState extends State<Accountsnew> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Container(
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

                        InkWell(
                            child: Icon(Icons.arrow_back,color: hmdarkolive),
                        ),
                        SizedBox(width: 10,),
                        Image.asset('assets/profile.png'),
                        SizedBox(width:15 ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Text('Tiara Sharma',style: TextStyle(fontSize: 20),
                              ),
                            ),
                            InkWell(
                                child: Text('View Profile ',style: TextStyle(color: hmdarkolive),)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),

                InkWell(
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
                InkWell(
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
                              Text("Vouchers"),
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
                              Text("contact us"),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('About ',style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Divider(thickness: 1),
                InkWell(
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
        ),

      ),
    );
  }
}
