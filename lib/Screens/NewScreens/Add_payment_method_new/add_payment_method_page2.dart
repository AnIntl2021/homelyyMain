import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../homellycolors.dart';

class Payment2 extends StatefulWidget {
  @override
  State<Payment2> createState() => _Payment2State();
}
class _Payment2State extends State<Payment2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          leading:Image.asset("assets/arrow left2.png")
      ),
      backgroundColor: Colors.white,
      body:
      Column(
        children: [
          Align( alignment: Alignment.center, child: Text("Add Voucher Code",style: TextStyle(fontSize: 20),)),
          SizedBox(height: 50,),Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Align( alignment: Alignment.centerLeft, child: Text("Card Number",style: TextStyle(fontSize: 16),)),
          ),SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,),
            child: Container(
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 10,left: 15),
                    fillColor: hmgreen,
                    filled: true,
                    hintText: "",
                    labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none
                    )
                ),

              ),
            ),
          ),

          SizedBox(height: 30,),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Align( alignment: Alignment.centerLeft, child: Row(
                children: [
                  Text("Expiry Date",style: TextStyle(fontSize: 16),),
                  SizedBox(width: 100,),
                  Text("CVV",style: TextStyle(fontSize: 16),)
                ],
              )),
            ),
          ),SizedBox(height: 5,),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,),
              child: Align(alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                      height: 40,width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 10,left: 15),
                            fillColor: hmgreen,
                            filled: true,
                            hintText: "MM/YY",
                            labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none
                            )
                        ),

                      ),
                    ),SizedBox(width: 30,), Container(
                      height: 40,width: 140,
                      child: TextFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 10,left: 15),
                            fillColor: hmgreen,
                            filled: true,
                            hintText: "123",
                            labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none
                            )
                        ),

                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          ,SizedBox(height: 30,),Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Align( alignment: Alignment.centerLeft, child: Text("Card Holder Name",style: TextStyle(fontSize: 16),)),
          ),SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,),
            child: Container(
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 10,left: 15),
                    fillColor: hmgreen,
                    filled: true,
                    hintText: "Full Name here",
                    labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none
                    )
                ),

              ),
            ),
          ),SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: hmolive,
                  borderRadius: BorderRadius.circular(20)),
              height: 40,
              width: 120,
              child: const Center(
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )),
            ),
          ),

        ],
      ),
    );
  }
}
