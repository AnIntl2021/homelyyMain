import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/orders/orderpage.dart';

class ThankScreen extends StatefulWidget {
  final String ref;

  const ThankScreen({Key key, this.ref}) : super(key: key);
  @override
  Splash createState() => Splash();
}

class Splash extends State<ThankScreen>  {

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Get.offAll(OrderPage(
        ref:widget.ref
      ));
    });

    var assetsImage = new AssetImage(
        'assets/thankyou.gif'); //<- Creates an object that fetches an image.
    var image = new Image(
        image: assetsImage,
        height: 300); //<- Creates a widget that displays an image.

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        /* appBar: AppBar(
          title: Text("MyApp"),
          backgroundColor:
              Colors.blue, //<- background color to combine with the picture :-)
        ),*/
        body: Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: image,
              ),
              Text("THANK YOU\nYOUR ORDER WILL ARRIVE IN 30 MINUTES",style: GoogleFonts.arvo(fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
            ],
          ),
        ), //<- place where the image appears
      ),
    );
  }
}