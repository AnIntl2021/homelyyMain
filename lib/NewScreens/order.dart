import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'homellycolors.dart';

class Ordernew extends StatefulWidget {
  const Ordernew({Key  key}) : super(key: key);

  @override
  _OrdernewState createState() => _OrdernewState();
}

class _OrdernewState extends State<Ordernew> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          backgroundColor: hmgreen,
          body: Container(
            child:Container(
              child: SingleChildScrollView(
                  child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              InkWell(
                                child: Icon(Icons.arrow_back,color: hmdarkolive),
                              ),


                            ],


                          ),

                        ),
                        SizedBox(height: 30 ),
                        Text('Your Order has been received\n by the restaurant!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        SizedBox(height:6 ),
                        Text("Raman's Food Corner is preparing\n your order   ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                        ),
                        Image.asset('assets/foodhomelyy.png'),
                        SizedBox(height: 15 ),
                Text("Your order is estimated to arrive by\n3:30 pm ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                ),
                        SizedBox(height: 30),
                        InkWell(
                          child: Container(
                            height: 40,width: Get.width* 0.5,
                            decoration: BoxDecoration(color: hmdarkolive,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Center(child: Text('Track Your Order',style: TextStyle(color: Colors.white),
                            )
                            ),

                          ),
                        ),

                    ]
                  ),

              ),
            ),
          ),
        )
    );
  }
}
