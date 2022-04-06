import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homellycolors.dart';

class Greenscreen extends StatefulWidget {
  const Greenscreen({Key key}) : super(key: key);

  @override
  _GreenscreenState createState() => _GreenscreenState();
}

class _GreenscreenState extends State<Greenscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: hmdarkolive,
          body: Container(

           child: Center(
             child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 90),
                   child: Text('Welcome to Homelly!',style: TextStyle(color: Colors.white,fontSize: 25),),
                 ),
                 Image.asset('assets/burger.png',height: 199),
                 SizedBox(height: 25),

                 Text('Order the food that you like! ',style: TextStyle(color: Colors.white,fontSize: 15),),
                 SizedBox(height: 25),
                 Padding(
                   padding: const EdgeInsets.only(left: 30,right: 30),
                   child: Text('Order food from anywhere, anytime. Discover many mouths savoring and figure licking handmade food at just one click.'

                   ,style: TextStyle(color: Colors.white,fontSize: 15),),
                 ),
               ],

             ),

           ),
          ),


        )

    );
  }
}
