import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Payment1 extends StatefulWidget {

  @override
  State<Payment1> createState() => _Payment1State();
}

class _Payment1State extends State<Payment1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          leading:Image.asset("assets/arrow left2.png")
      ),
      backgroundColor: Colors.white,
body: Column(
  children: [
    Align( alignment: Alignment.center, child: Text("Add Payment Method",style: TextStyle(fontSize: 20),)),
    SizedBox(height: 30,),
    Container(
      child: TextFormField(
        obscureText: true,
decoration: InputDecoration(
  prefixIcon:Image.asset("assets/visa.png"),
  suffixIcon: ClipRRect(child: Image.asset("assets/right arrow 2.png",)),
  border: OutlineInputBorder(borderSide: BorderSide.none)
),
      ),
    ),
    Container(
        width: 300,
        child: Divider(thickness: .5,color: Colors.grey,)),
    Container(
      child: TextFormField(
        decoration: InputDecoration(
            prefixIcon:Image.asset("assets/paypal.png"),
            suffixIcon: ClipRRect(child: Image.asset("assets/right arrow 2.png",)),
            border: OutlineInputBorder(borderSide: BorderSide.none)
        ),

      ),
    ),
    Container(
        width: 300,
        child: Divider(thickness: .5,color: Colors.grey,)),
    Container(
      child: TextFormField(
        decoration: InputDecoration(
            prefixIcon:Image.asset("assets/gift card.png"),
            suffixIcon: ClipRRect(child: Image.asset("assets/right arrow 2.png",)),
            border: OutlineInputBorder(borderSide: BorderSide.none)
        ),
      ),
    ),
    Container(
        width: 300,
        child: Divider(thickness: .5,color: Colors.grey,))
  ],
),
    );
  }
}
