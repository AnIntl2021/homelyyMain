import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelyy/Screens/NewScreens/homellycolors.dart';

class Payment3 extends StatefulWidget {


  @override
  State<Payment3> createState() => _Payment3State();
}

class _Payment3State extends State<Payment3> {
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
          child: Align( alignment: Alignment.centerLeft, child: Text("Add Voucher Card")),
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
                  hintText: "Enter Code here",
                  labelStyle: TextStyle(fontSize: 18,color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none
                  )
                ),

              ),
            ),
          ),
          SizedBox(height: 60,),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: hmolive,
                  borderRadius: BorderRadius.circular(20)),
              height: 40,
              width: 160,
              child: const Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
