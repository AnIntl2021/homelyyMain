import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'homellycolors.dart';

class Offersnew extends StatefulWidget {
  const Offersnew({Key  key}) : super(key: key);

  @override
  _OffersnewState createState() => _OffersnewState();
}

class _OffersnewState extends State<Offersnew> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            child: SingleChildScrollView(
              child: Center(

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Ink(
                              child: Icon(Icons.arrow_back,color: hmdarkolive,)
                          ),


                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Text('Your Offers & Discounts',style: TextStyle(fontSize: 20 ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left:20 ),
                      child: Row(
                        children: [
                          Image.asset('assets/coupon.png'),
                          SizedBox(width: 10 ),
                          Text('For uptp 2 orders',style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold),
                          ),

                        ],

                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(right: 95),
                      child: Text('Enjoy 50% off(upto \$30 )',style: TextStyle(fontSize: 20)
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Text(' \$50 minimum order placed only at the particapting restaurants  ',style: TextStyle(fontSize: 15)
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(' Delivery orders only',style: TextStyle(fontSize: 15)
                              ),

                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              InkWell(
                                child: Container(height: 20,width: Get.width *0.4,decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: hmdarkolive,),
                                child: Center(
                                  child: Text('Claim Now',style: TextStyle(color: Colors.white),
                                  ),
                                )
                                ),
                              ),


                            ],
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                InkWell(
                                                                  onTap:(){
                                                                    Get.back();
                                                      },
                                                                    child: Icon(Icons.cancel)
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [

                                                                Text('Expiry Date ',style: TextStyle(fontSize: 20,
                                                                    color: Colors.black),
                                                                ),



                                                              ],
                                                            ),
                                                            Divider(
                                                              color: Colors.black,
                                                            ),
                                                            SizedBox(height: 4),
                                                            Row(
                                                              children: [
                                                                Text('March 28,2022at 12 am',style: TextStyle(fontSize: 15,color: Colors.black),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 4),
                                                            Row(
                                                              children: [
                                                                Text('Location',style: TextStyle(fontSize: 20,color: Colors.black),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              color: Colors.black,thickness: 1,
                                                            ),
                                                            SizedBox(height: 4),
                                                            Row(
                                                              children: [
                                                                Text('Canada',style: TextStyle(fontSize: 15,color: Colors.black),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 20),
                                                            Row(
                                                              children: [
                                                                Text('Details',style: TextStyle(fontSize: 20,color: Colors.black),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              color: Colors.black,thickness: 1,
                                                            ),
                                                            SizedBox(height:10),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Text('Th offer isvaild  only upto 30%\n \$50 or more',style: TextStyle(fontSize: 13,color: Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                )










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

                                  child:
                              Row(
                                children: [
                                  Text("See Details"),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              )
                              ),

                            ],

                          ),

                        ],
                      ),
                    ),






                  ],
                ),

              ),

            ),

          )
          ),
        );

  }
}
